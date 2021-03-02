//
//  Dashboard.swift
//  wulkanowy
//
//  Created by Tomasz on 23/02/2021.
//

import SwiftUI
import KeychainAccess
import Sdk

struct DashboardView: View {
    init() {
        let keychain = Keychain()
        let key = keychain["privateKey"]
        
        let luckyNumber = getLuckyNumber()
        print(luckyNumber)
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("You are not logged in (dashboard)")
                NavigationLink(destination: LoginView()) {
                    Text("Log in")
                }
            }.padding()
        }
    }
}



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
        }
        .preferredColorScheme(.dark)
    }
}

