//
//  luckyNumber.swift
//  
//
//  Created by Tomasz on 27/02/2021.
//

import Foundation
import KeychainAccess
import SwiftyJSON

@available (iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public func getLuckyNumber() -> Int {
    let keychain = Keychain()
    let actualStudent = keychain["actualStudent"] ?? "{}"
    let data: Data = Data(actualStudent.utf8)
    let actualStudentJSON = try! JSON(data: data)
    let Id = "\(actualStudentJSON["ConstituentUnit"]["Id"])"
    
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let day = formatter.string(from: date)
    
    let RestURL = "\(actualStudentJSON["Unit"]["RestURL"])/mobile/school/lucky?constituentId=\(Id)&day=\(day)"
    
    let apiResponseRequest = apiRequest(endpointURL: RestURL)
    
    let session = URLSession.shared
    session.dataTask(with: apiResponseRequest) { (data, response, error) in
        if let error = error {
            // Handle HTTP request error
            print(error)
        } else if let data = data {
            // Handle HTTP request response
            let responseBody = String(data: data, encoding: String.Encoding.utf8)
            
            print(responseBody!)
            
        } else {
            // Handle unexpected error
        }
    }.resume()
    
    return 7
}
