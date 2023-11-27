//
//  ShareUseActivityVC.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 26.11.2023.
//

import UIKit
import SwiftUI

struct ShareUseActivityViewController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareUseActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareUseActivityViewController>) {}

}
