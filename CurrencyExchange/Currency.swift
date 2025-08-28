//
//  Currency.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import Foundation

struct Currency: Codable, Identifiable, Equatable {
    let code: String
    let name: String
    let country: String
    let countryCode: String
    let flag: String?

    var id: String { code }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.code = try container.decode(String.self, forKey: .code)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.country = try container.decode(String.self, forKey: .country)
//        self.countryCode = try container.decode(String.self, forKey: .countryCode)
//        self.flag = try? container.decode(String.self, forKey: .flag)
//
//        if self.flag == nil {
//            print("⚠️ Missing flag for currency: \(code)")
//        }
//    }
    
}
