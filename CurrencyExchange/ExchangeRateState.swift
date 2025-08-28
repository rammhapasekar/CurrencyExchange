//
//  ExchangeRateState.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import Foundation

struct ExchangeRateState: Equatable {
    var baseCurrency: String
    var targetCurrency: String
    var amount: String
    var availableCurrencies: [Currency]
    var filteredCurrencies: [Currency]
    var searchText: String
    var isLoading: Bool
    var result: String?
    var error: String?
    
    static func initial() -> ExchangeRateState {
        ExchangeRateState(
            baseCurrency: Locale.current.currency?.identifier ?? "USD",
            targetCurrency: "USD",
            amount: "1",
            availableCurrencies: [],
            filteredCurrencies: [],
            searchText: "",
            isLoading: false,
            result: nil,
            error: nil
        )
    }
}
