//
//  QRScannerDelegate.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 26.11.2023.
//

import SwiftUI
import AVKit
import AVFoundation

class QRScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    
    @Published var code: String?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let scannedCode = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

            print(scannedCode)
            
            code = scannedCode
        }
    }
    
}
