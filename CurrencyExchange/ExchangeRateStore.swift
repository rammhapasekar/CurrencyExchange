//
//  ExchangeRateStore.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import Combine
import Foundation

final class ExchangeRateStore: ObservableObject {
    @Published private(set) var state = ExchangeRateState.initial()

    private let apiKey = "YOUR-API-KEY"
    private var cancellables = Set<AnyCancellable>()

    init() {
        dispatch(.loadCurrencies)
    }

    func dispatch(_ intent: ExchangeRateIntent) {
        switch intent {
        case .loadCurrencies:
            loadCurrencies()

        case .searchChanged(let text):
            state.searchText = text
            filterCurrencies()

        case .selectCurrency(let code):
            state.targetCurrency = code
            dispatch(.convert)

        case .amountChanged(let value):
            state.amount = value

        case .convert:
            fetchExchangeRate()
        }
    }

    private func reduce(_ effect: ExchangeRateEffect) {
        switch effect {
        case .didLoadCurrencies(let currencies):
            state.availableCurrencies = currencies.sorted(by: { $0.code < $1.code })
            state.filteredCurrencies = currencies
            if !currencies.contains(where: { $0.code == state.targetCurrency }) {
                state.targetCurrency = currencies.first?.code ?? "USD"
            }

        case .didFailToLoadCurrencies(let error):
            state.error = error

        case .didReceiveConversion(let result):
            state.result = result
            state.isLoading = false

        case .didFailConversion(let error):
            state.error = error
            state.isLoading = false
        }
    }

    private func filterCurrencies() {
        let search = state.searchText.lowercased()
        if search.isEmpty {
            state.filteredCurrencies = state.availableCurrencies
        } else {
            state.filteredCurrencies = state.availableCurrencies.filter {
                $0.name.lowercased().contains(search) ||
                $0.country.lowercased().contains(search)
            }
        }
    }

    private func loadCurrencies() {
        guard let url = Bundle.main.url(forResource: "currencies", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let currencies = try? JSONDecoder().decode([Currency].self, from: data) else {
            reduce(.didFailToLoadCurrencies("Failed to load currencies"))
            return
        }

        reduce(.didLoadCurrencies(currencies))
    }

    private func fetchExchangeRate() {
        guard let amountValue = Double(state.amount) else {
            reduce(.didFailConversion(error: "Invalid amount"))
            return
        }

        state.isLoading = true
        state.result = nil
        state.error = nil

        let urlString = "https://v6.exchangerate-api.com/v6/\(apiKey)/pair/\(state.baseCurrency)/\(state.targetCurrency)/\(amountValue)"
        guard let url = URL(string: urlString) else {
            reduce(.didFailConversion(error: "Invalid URL"))
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                let errorResponse = try? JSONDecoder().decode(ExchangeRateErrorResponse.self, from: data)
                if let err = errorResponse, err.result == "error" {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ExchangeRateResponse.self, decoder: JSONDecoder())
            .map { ExchangeRateEffect.didReceiveConversion(result: "\($0.conversion_result) \($0.target_code)") }
            .catch { Just(ExchangeRateEffect.didFailConversion(error: $0.localizedDescription)) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] effect in
                self?.reduce(effect)
            }
            .store(in: &cancellables)
    }
}

extension ExchangeRateStore {
    func injectCurrencies(_ currencies: [Currency]) {
        state.availableCurrencies = currencies
        state.filteredCurrencies = currencies
    }
    func injectTargetCurrency(_ currency: String) {
        state.targetCurrency = currency
    }
    func injectAmount(_ amount: String) {
        state.amount = amount
    }
}
