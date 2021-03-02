//
//  getSignatures.swift
//  
//
//  Created by Tomasz on 02/03/2021.
//

import Foundation
import KeychainAccess

@available (iOS 14, macOS 11, watchOS 7, tvOS 14, *)
func getSignatures(request: URLRequest, certificate: X509) -> String {
    guard let urlString = request.url?.absoluteString else {
        return "\(Sdk.APIError.urlError)"
    }
    
    // Get private key
    guard let privateKeyRawData = certificate.getPrivateKeyData(format: .DER),
          let privateKeyString = String(data: privateKeyRawData, encoding: .utf8)?
            .split(separator: "\n")
            .dropFirst()
            .dropLast()
            .joined()
            .data(using: .utf8) else {
        return "\(Sdk.APIError.noPrivateKey)"
    }
    
    // Create SecKey
    let attributes = [
        kSecAttrKeyType: kSecAttrKeyTypeRSA,
        kSecAttrKeyClass: kSecAttrKeyClassPrivate,
    ]
    guard let privateKeyData = Data(base64Encoded: privateKeyString),
          let secKey = SecKeyCreateWithData(privateKeyData as NSData, attributes as NSDictionary, nil) else {
        return "\(Sdk.APIError.noPrivateKey)"
    }
    
    // Get fingerprint
    guard let signatureValues = Sdk.Signer.getSignatureValues(body: request.httpBody, url: urlString, privateKey: secKey, fingerprint: certificate.getCertificateFingerprint().lowercased()) else {
        return "\(Sdk.APIError.noPrivateKey)"
    }
    
    // Headers
    let keychain = Keychain()
    let fingerprint: String! = keychain["keyFingerprint"]
    
    let signature = "\(signatureValues.signature.replacingOccurrences(of: "nil", with: fingerprint))"
    
    return signature
}
