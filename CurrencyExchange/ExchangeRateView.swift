//
//  ExchangeRateView.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import SwiftUI

struct ExchangeRateView: View {
    @ObservedObject var store: ExchangeRateStore

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 12) {
                    Text("Base currency: \(store.state.baseCurrency)")
                        .font(.subheadline)

                    TextField("Amount", text: Binding(
                        get: { store.state.amount },
                        set: { store.dispatch(.amountChanged($0)) }
                    ))
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Search country or currency...", text: Binding(
                        get: { store.state.searchText },
                        set: { store.dispatch(.searchChanged($0)) }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                List(store.state.filteredCurrencies) { currency in
                    Button {
                        store.dispatch(.selectCurrency(code: currency.code))
                    } label: {
                        HStack {
                            AsyncFlagImage(currency: currency, size: CGSize(width: 32, height: 20))
                            VStack(alignment: .leading) {
                                Text(currency.country)
                                    .font(.headline)
                                Text("\(currency.name) (\(currency.code))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            if currency.code == store.state.targetCurrency {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                if store.state.isLoading {
                    ProgressView().padding(.top)
                }

                if let error = store.state.error {
                    Text("Error: \(error)").foregroundColor(.red).padding(.top)
                } else if let result = store.state.result {
                    Text("Result: \(result)").font(.headline).padding()
                }
            }
            .navigationTitle("Currency Converter")
        }
    }
}
