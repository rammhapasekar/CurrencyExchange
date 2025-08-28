//
//  ExchangeRateIntent.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import Foundation

enum ExchangeRateIntent {
    case loadCurrencies
    case searchChanged(String)
    case selectCurrency(code: String)
    case amountChanged(String)
    case convert
}
