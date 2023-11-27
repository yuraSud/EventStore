//
//  QRCodeGenerator.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 26.11.2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QrCodeGenerator {
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 5, y: 5)

        if let output = filter.outputImage?.transformed(by: transform) {
            if let qrCodeCGImage = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
