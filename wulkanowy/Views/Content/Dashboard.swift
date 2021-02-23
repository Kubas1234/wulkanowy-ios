//
//  Dashboard.swift
//  wulkanowy
//
//  Created by Tomasz on 23/02/2021.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        Text("You are not logged in")
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                        }
                        
                    }
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

