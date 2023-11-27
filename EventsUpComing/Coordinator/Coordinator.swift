//
//  Coordinator.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 10.11.2023.
//

import SwiftUI

class Coordinator: ObservableObject {
    
    @State var path = NavigationPath()
    @Published var sheet: Sheets?
    @EnvironmentObject var viewModel: EventViewModel
    @StateObject var shareViewModel = ShareViewModel()
    @Published var isShowAlert = false {
        didSet {
            print(isShowAlert, "didset")
        }
    }
    @Published var errorMessage = ""
    
    func push(page: Page) {
        path.append(page)
    }
    
    func present(sheet: Sheets) {
        self.sheet = sheet
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func addIvent(ivent: IventModel) {
        viewModel.appendEvent(event: ivent)
    }
    
    func showAlert(message: String) {
        dismissSheet()
        errorMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isShowAlert.toggle()
        }
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .content:
            ContentView()
        case .eventsList:
            EventListView()
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheets, iventModel: IventModel) -> some View {
        if sheet == .editIvent(iventModel) {
            EditEvents(iventModel: iventModel)
        } else if sheet == .shareUseActivityVC(iventModel) {
            let eventString = shareViewModel.transformEventToString(event: iventModel)
            ShareUseActivityViewController(activityItems: [eventString])
        } else if sheet == .shareByQRCode(iventModel) {
            let encodeString = EncodeDecodeManager.encodeEventModelToString(event: iventModel)
            ShareQRCodeView(titleEvent: iventModel.title, textToShare: encodeString)
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheets) -> some View {
        if sheet == .shared {
            QRCodeScanerView()
        } else if sheet == .createEvent {
            CreateEventsView()
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheets, encodeString: String) -> some View {
        let event = EncodeDecodeManager.decodeStringToEvent(encodeString: encodeString)
        CreateEventsView(model: event, isFromQRCode: true)
    }
}
