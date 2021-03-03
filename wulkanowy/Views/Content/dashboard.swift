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
    @State private var showModal = false
    @AppStorage("isLogged") private var isLogged: Bool = false
    
    var body: some View {
        if(isLogged == false){
            VStack {
                Text("You are not logged in")
                Button("Log in") {self.showModal = true}
                    .sheet(isPresented: $showModal, onDismiss: {
                                print(self.showModal)
                            }) {
                                LoginView()
                            }
            }.padding()
        } else {
            Text("Here is dashboard (in my imagination)")
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

