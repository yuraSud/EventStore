//
//  ShareQRCodeView.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 26.11.2023.
//

import SwiftUI

struct ShareQRCodeView: View {
    @State var image = QrCodeGenerator()
    @EnvironmentObject var coordinator: Coordinator
    let titleEvent: String
    let textToShare: String
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                
                Button { coordinator.dismissSheet()
                } label: {
                    Image(systemName: "xmark")
                        .padding(10)
                        .background(.indigo)
                        .clipShape(Circle())
                        .foregroundStyle(.white)
                        .padding()
                }
            }
           
            Text(titleEvent)
                .font(.title2)
                .padding()
                .padding(.top, 60)
            
            Image(uiImage: image.generateQRCode(from: textToShare))
                .resizable()
                .frame(width: 300, height: 300)
                .scaledToFit()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ShareQRCodeView(titleEvent: "Yura topic", textToShare: "Yura")
        .environmentObject(Coordinator())
}
