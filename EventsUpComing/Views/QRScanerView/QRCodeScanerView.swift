//
//  SharedView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI
import AVKit
import AVFoundation

struct QRCodeScanerView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.openURL) private var openURL
    @State private var isScaning = false
    @State private var session: AVCaptureSession = .init()
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var cameraPermission = PermissionCamera.idle
    @State private var isShowAlert = false
    @StateObject private var qrScannerDelegate = QRScannerDelegate()
    @State var num = 0
    
    @State var captureSession: AVCaptureSession!
    @State var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    var body: some View {
        VStack {
            Button { coordinator.dismissSheet()
            } label: {
                Image(systemName: "xmark")
                    .padding(10)
                    .background(.indigo)
                    .clipShape(Circle())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
            }
            
            Text("Place the QRCode inside the area")
                .font(.title3)
            Text("Scanning will start automatically")
                .font(.callout)
                .foregroundStyle(.gray)
            
            Spacer()
            
            GeometryReader {
                let size = $0.size
                
                ZStack {
                    CameraView(frameSize: CGSize(width: 300, height: 300), session: $session)
                        .frame(width: size.width, height: size.width)
                        .scaleEffect(0.95)
                    
                    ForEach(0...4, id: \.self) { index in
                        let rotation = Double(index) * 90
                        
                        RoundedRectangle(cornerRadius: 4, style: .circular)
                            .trim(from: 0.6, to: 0.65)
                            .stroke(Color.blue, style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(rotation))
                    }
                }
                .frame(width: size.width, height: size.width)
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(Color.red)
                        .frame(height: 2.5)
                        .shadow(color: .orange, radius: 8, x: 0, y: isScaning ? 15 : -15)
                        .offset(y: isScaning ? size.width : 0)
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 45)
            
            Spacer()
            
            Button {
                if !session.isRunning && cameraPermission == .approved {
                    reActivateCamera()
                    activateScanerAnimation()
                }
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .padding(10)
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .padding(.bottom, 40)
            }
        }
        .onAppear(perform: checkPermission)
        .alert("Warning", isPresented: $isShowAlert) {
            
            if cameraPermission == .denied {
                Button("Go Settings") {
                    let settingsString = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settingsString) {
                        openURL(settingsURL)
                    }
                }
            }
            
            Button ("Cancel") { errorMessage = "" }
        } message: {
            Text(errorMessage)
        }
        .onChange(of: qrScannerDelegate.code) { oldValue, newValue in
            if let code = newValue {
                num += 1
                session.stopRunning()
                print(num, "num")
                coordinator.present(sheet: .createEventFromQR(code))
            }
        }
    }
    
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDualWideCamera], mediaType: .video, position: .back).devices.first else {
                showAlert(message: "Unknow Error")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                showAlert(message: "Unkow error input/output")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(qrScannerDelegate, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .default).async {
                session.startRunning()
            }
            activateScanerAnimation()
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }
    
    func activateScanerAnimation() {
        withAnimation(.easeInOut(duration: 1.5)
            .delay(0.3)
            .repeatForever(autoreverses: true)) {
                isScaning = true
            }
    }
    
    func deActivateScanerAnimation() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isScaning = false
        }
    }
    
    func reActivateCamera() {
        DispatchQueue.global(qos: .default).async {
            session.startRunning()
        }
    }
    
    func checkPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                    setupCamera()
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    cameraPermission = .denied
                    showAlert(message: "Please provide access to camera for scanning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                showAlert(message: "Please provide access to camera for scanning codes")
            default: break
            }
        }
    }
    
    func showAlert(message: String) {
        errorMessage = message
        isShowAlert.toggle()
    }
}

#Preview {
    QRCodeScanerView()
        .environmentObject(Coordinator())
}
