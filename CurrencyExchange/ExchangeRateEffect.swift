//
//  ExchangeRateEffect.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import Foundation

enum ExchangeRateEffect {
    case didLoadCurrencies([Currency])
    case didFailToLoadCurrencies(String)
    case didReceiveConversion(result: String)
    case didFailConversion(error: String)
}
