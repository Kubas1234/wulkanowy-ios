//
//  wulkanowyApp.swift
//  wulkanowy
//
//  Created by Mikołaj on 25/10/2020.
//

import SwiftUI
import Sdk
import Combine
import SwiftyJSON
import KeychainAccess

@main
struct wulkanowyApp: App {
    @AppStorage("isLogged") private var isLogged: Bool = false
    
    init() {
        if(isLogged == true) {
            let keychain = Keychain()
            let actualStudentId = "\(keychain["actualStudentId"] ?? "0")"
            let accountString = keychain[actualStudentId]
            let data: Data = Data(accountString!.utf8)
            let account = try! JSON(data: data)
            
            let endpointURL: String = "\(account["account"]["RestURL"])api/mobile/register/hebe"
            
            let apiResponseRequest = apiRequest(endpointURL: endpointURL)
            let session = URLSession.shared
            session.dataTask(with: apiResponseRequest) { (data, response, error) in
                if let error = error {
                    // Handle HTTP request error
                    print(error)
                } else if let data = data {
                    // Handle HTTP request response
                    let responseBody = String(data: data, encoding: String.Encoding.utf8)
                    keychain["actualStudentHebe"] = "\(responseBody!)"
                } else {
                    // Handle unexpected error
                }
            }.resume()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationBarView()
        }
    }
}
