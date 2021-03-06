//
//  hebeRequest.swift
//  
//
//  Created by Tomasz on 05/03/2021.
//

import Foundation
import KeychainAccess
import SwiftyJSON

@available (iOS 14, macOS 11, watchOS 7, tvOS 14, *)
func hebeRequest(id: String) {
    let keychain = Keychain()
    let account = keychain[id] ?? "[]"
    let data = Data(account.utf8)
    let accountJSON = try! JSON(data: data)
    
    let fingerprint: String = "\(accountJSON["fingerprint"])"
    let privateKeyStringString: String = "\(accountJSON["privateKeyString"])"
    let privateKeyString: Data = Data(privateKeyStringString.utf8)
    let deviceModel: String = "\(accountJSON["deviceModel"])"
    
    let url = "\(accountJSON["account"]["RestURL"])api/mobile/register/hebe"
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"
    
    let now = Date()
    var vDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return "\(dateFormatter.string(from: now)) GMT"
    }
    
    let signatures = getSignatures(request: request, fingerprint: fingerprint, privateKeyString: privateKeyString)
    request.setValue("\(signatures)", forHTTPHeaderField: "Signature")
    
    request.allHTTPHeaderFields = [
        "User-Agent": "wulkanowy/1 CFNetwork/1220.1 Darwin/20.1.0",
        "vOS": "iOS",
        "vDeviceModel": deviceModel,
        "vAPI": "1",
        "vDate": vDate,
        "vCanonicalUrl": "api%2fmobile%2fregister%2fhebe"
    ]
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            // Handle HTTP request error
            print(error)
        } else if let data = data {
            // Handle HTTP request response
            let responseBody = String(data: data, encoding: String.Encoding.utf8)
            
            let keychain = Keychain()
            keychain["students"] = responseBody!
            
        } else {
            // Handle unexpected error
        }
    }

    task.resume()
}

