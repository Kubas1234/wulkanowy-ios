//
//  messages.swift
//  wulkanowy
//
//  Created by Tomasz on 26/02/2021.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        Text("You are not logged in (messages)")
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                        }
                    }.padding()
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
