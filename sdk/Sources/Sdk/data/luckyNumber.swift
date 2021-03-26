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
    let actualStudentId = "\(keychain["actualStudentId"] ?? "0")"
    let actualAccount = keychain[actualStudentId]
    let dataAccount: Data = Data(actualAccount!.utf8)
    let actualAccountJSON = try! JSON(data: dataAccount)
    let studentId = Int("\(actualAccountJSON["actualStudent"])")
    let actualStudentHebe = keychain["actualStudentHebe"]
    let dataHebe: Data = Data(actualStudentHebe!.utf8)
    let actualStudentHebeJSON = try! JSON(data: dataHebe)
    let actualStudent = actualStudentHebeJSON["Envelope"][studentId!]
    let Id = "\(actualStudent["ConstituentUnit"]["Id"])"
    
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let day = formatter.string(from: date)
    
    let RestURL = "\(actualStudent["Unit"]["RestURL"])/mobile/school/lucky?constituentId=\(Id)&day=\(day)"
    
    let apiResponseRequest = apiRequest(endpointURL: RestURL, id: actualStudentId)
    
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
