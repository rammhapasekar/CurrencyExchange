//
//  AsyncFlagImage.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import SwiftUI

struct AsyncFlagImage: View {
    let currency: Currency
    let size: CGSize

    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image(systemName: "flag.slash.fill")
                    .resizable()
                    .foregroundColor(.gray)
                    .opacity(0.6)
            }
        }
        .frame(width: size.width, height: size.height)
        .cornerRadius(3)
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        let fileURL = getCacheDirectory().appendingPathComponent("\(currency.code).png")

        if FileManager.default.fileExists(atPath: fileURL.path),
           let data = try? Data(contentsOf: fileURL),
           let cachedImage = UIImage(data: data) {
            self.image = cachedImage
            return
        }

        // Decode base64
        guard let base64 = currency.flag?.components(separatedBy: ",").last,
              let data = Data(base64Encoded: base64),
              let uiImage = UIImage(data: data) else {
            return
        }

        // Save to cache
        try? data.write(to: fileURL)
        self.image = uiImage
    }

    private func getCacheDirectory() -> URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
}
