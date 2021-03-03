//
//  messages.swift
//  wulkanowy
//
//  Created by Tomasz on 26/02/2021.
//

import SwiftUI

struct MessagesView: View {
    @State private var showModal = false
    @AppStorage("isLogged") private var isLogged: Bool = false
    
    var body: some View {
        NavigationView {
            if(isLogged == false){
                VStack {
                    Text("You are not logged in (messages)")
                    Button("Log in") {self.showModal = true}
                        .sheet(isPresented: $showModal, onDismiss: {
                                    print(self.showModal)
                                }) {
                                    LoginView()
                                }
                }.padding()
            } else {
                Text("Here are messages (in my imagination)")
            }
        }
    }
}



struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessagesView()
        }
        .preferredColorScheme(.dark)
    }
}
