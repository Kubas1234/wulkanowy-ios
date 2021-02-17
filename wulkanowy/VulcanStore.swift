//
//  VulcanStore.swift
//  wulkanowy
//
//  Created by Tomasz (copied from rrroyal/vulcan) on 16/02/2021.
//

import Combine
import Sdk

final class VulcanStore: ObservableObject {
    static let shared: VulcanStore = VulcanStore()

    let sdk: Sdk?
    private init() {
        // Check for stored certificate
        guard let certificate: X509 = try? X509(serialNumber: 1, certificateEntries: ["CN": "APP_CERTIFICATE CA Certificate"]) else {
            sdk = nil
            return
        }
        
        sdk = Sdk(certificate: certificate)
    }
    
    public func login(token: String, symbol: String, pin: String, deviceModel: String, completionHandler: @escaping (Error?) -> Void) {
        sdk?.login(token: token, symbol: symbol, pin: pin, deviceModel: deviceModel) { error in
            if error == nil {
                // Success - save certificate
            } else {
                // Error - discard or try again
            }
            
            completionHandler(error)
        }
    }
}

