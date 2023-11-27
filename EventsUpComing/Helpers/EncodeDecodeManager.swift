//
//  EncodeDecodeManager.swift
//  EventsUpComing
//
//  Created by Yura Sabadin on 26.11.2023.
//

import Foundation

struct EncodeDecodeManager {
    
    static func encodeEventModelToString(event: IventModel) -> String {
        do {
            let jsonData = try JSONEncoder().encode(event)
            let base64EncodedString = jsonData.base64EncodedString()
            return base64EncodedString
        } catch {
            print("Error encoding struct to JSON: \(error)")
        }
        return "I can't encrypt the data to String"
    }
    
    static func decodeStringToEvent(encodeString: String) -> IventModel {
        guard let decodedData = Data(base64Encoded: encodeString),
              let event = try? JSONDecoder().decode(IventModel.self, from: decodedData)
        else {
            return IventModel(title: "I can't decrypt the data")
        }
        return event
    }
}
