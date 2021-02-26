//
//  VulcanStore.swift
//  wulkanowy
//
//  Created by Tomasz (copied from rrroyal/vulcan) on 16/02/2021.
//

import Combine
import Sdk
import Foundation
import KeychainAccess

final class VulcanStore: ObservableObject {
    static let shared: VulcanStore = VulcanStore()
    
    var privateKey: String?
    let sdk: Sdk?
    private init() {
        // Check for stored certificate
        guard let certificate: X509 = try? X509(serialNumber: 1, certificateEntries: ["CN": "APP_CERTIFICATE CA Certificate"]) else {
            sdk = nil
            privateKey = nil
            return
        }
        
        guard let privateKeyRawData = certificate.getPrivateKeyData(format: .DER),
              let privateKeyString = String(data: privateKeyRawData, encoding: .utf8)?
                    .split(separator: "\n")
                    .dropFirst()
                    .dropLast()
                    .joined() else {
            privateKey = nil
            sdk = nil
            return
        }
        
        privateKey = privateKeyString
        
        sdk = Sdk(certificate: certificate)
    }
    
    public func login(token: String, symbol: String, pin: String, deviceModel: String, completionHandler: @escaping (Error?) -> Void) {
        sdk?.login(token: token, symbol: symbol, pin: pin, deviceModel: deviceModel) { [self] error in
            if let error = error {
                // Wyobraź sobie, że tutaj jest obsługa błędów. Wyobraź, bo mi sie jej robić nie chciało.
                print(error)
            } else {
                let privateKeyToSave: String = privateKey ?? ""

                let utf8str = privateKeyToSave.data(using: .utf8)

                if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
                    let keychain = Keychain()
                    keychain[string: "privateKey"] = base
                    
                    let token = keychain["privateKey"]
                    print("Encoded: \(token)")
                }
            }
            
            completionHandler(error)
        }
    }
}

