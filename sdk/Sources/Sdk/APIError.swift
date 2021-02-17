//
//  File.swift
//  
//
//  Created by Tomasz (copied from rrroyal/vulcan) on 15/02/2021.
//

import Foundation

@available (iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension Sdk {
    enum APIError: Error {
        case error(reason: String)
        case jsonSerialization
        case noEndpointURL
        case noFirebaseToken
        case noCertificate
        case noPrivateKey
        case noSignatureValues
        case urlError
        
        case wrongToken
        case wrongPin
    }
}

