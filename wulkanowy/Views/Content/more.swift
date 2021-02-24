//
//  more.swift
//  wulkanowy
//
//  Created by Tomasz on 24/02/2021.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        Text("You are not logged in (more)")
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                        }
                    }.padding()
                }
    }
}



struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoreView()
        }
        .preferredColorScheme(.dark)
    }
}
