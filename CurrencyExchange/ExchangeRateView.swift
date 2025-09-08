//
//  ExchangeRateView.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import SwiftUI

struct ExchangeRateView: View {
    @ObservedObject var store: ExchangeRateStore
  @FocusState private var countrySelectionIsFocused: Bool

    var body: some View {
        NavigationView {
          ZStack{
            RadialGradient(stops: [
              .init(color: Color(red:0.26, green: 0.15, blue: 0.76), location: 0.3),
              .init(color: Color(red:0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 150, endRadius: 700)
            .ignoresSafeArea()
            VStack {
              VStack(spacing: 12) {
                Text("Base currency: \(store.state.baseCurrency)")
                  .font(.headline)
                  .foregroundColor(.primary)
                
                TextField("Amount", text: Binding(
                  get: { store.state.amount },
                  set: { store.dispatch(.amountChanged($0)) }
                ))
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($countrySelectionIsFocused)
                
                TextField("Search country or currency...", text: Binding(
                  get: { store.state.searchText },
                  set: { store.dispatch(.searchChanged($0)) }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($countrySelectionIsFocused)
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
              }.scrollContentBackground(.hidden)
              
              if store.state.isLoading {
                ProgressView().padding(.top)
              }
              
              if let error = store.state.error {
                Text("Error: \(error)").foregroundColor(.red).padding(.top)
              } else if let result = store.state.result {
                Text("Result: \(result)").accessibilityIdentifier("ConversionResult").font(.headline).padding()
              }
            }
          }
            .navigationTitle("Currency Converter")
            .toolbar{
              if countrySelectionIsFocused{
                Button("Done"){
                  countrySelectionIsFocused = false
                }
                .foregroundColor(.white)
              }
            }
        }
    }
}
