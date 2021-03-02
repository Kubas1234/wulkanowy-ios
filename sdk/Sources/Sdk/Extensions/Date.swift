//
//  File.swift
//  
//
//  Created by Tomasz (copied from rrroyal/vulcan) on 15/02/2021.
//

import Foundation

@available (iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension Date {
    func formattedString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}
