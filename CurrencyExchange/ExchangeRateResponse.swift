//
//  ExchangeRateResponse.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import Foundation

struct ExchangeRateResponse: Codable {
    let result: String
    let base_code: String
    let target_code: String
    let conversion_rate: Double
    let conversion_result: Double
}

struct ExchangeRateErrorResponse: Codable {
    let result: String
    let error_type: String
}
