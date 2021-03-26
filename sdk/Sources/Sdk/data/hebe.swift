//
//  File.swift
//  
//
//  Created by Tomasz on 12/03/2021.
//

import Foundation
import KeychainAccess
import SwiftyJSON
import SwiftUI

@available (iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public func getHebe(id: String, account: JSON) -> JSON {
    let RestURL = "\(account["account"]["RestURL"])api/mobile/register/hebe"
    let keychain = Keychain()
    let hebeRequest = apiRequest(endpointURL: "\(RestURL)", id: id)
    let session = URLSession.shared
    var hebe: String = ""
    session.dataTask(with: hebeRequest) { (data, response, error) in
        if let error = error {
            // Handle HTTP request error
            print(error)
        } else if let data = data {
            // Handle HTTP request response
            let responseBody = String(data: data, encoding: String.Encoding.utf8)
            hebe = "\(responseBody!)"
        } else {
            // Handle unexpected error
        }
    }.resume()
    
    var hebeJSON: JSON?
    while true {
        if(hebe != ""){
            let data: Data = Data(hebe.utf8)
            hebeJSON = try! JSON(data: data)
            break
        } else {
            continue
        }
    }
    
    return hebeJSON!
}
