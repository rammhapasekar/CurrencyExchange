//
//  ContentView.swift
//  CurrencyExchange
//
//  Created by Ram Mhapasekar on 28/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ExchangeRateView(store: ExchangeRateStore())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
