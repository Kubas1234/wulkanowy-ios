//
//  attendance.swift
//  wulkanowy
//
//  Created by Tomasz on 24/02/2021.
//

import SwiftUI

struct ExamsView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        Text("You are not logged in (Exams)")
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                        }
                    }.padding()
                }
    }
}



struct ExamsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExamsView()
        }
        .preferredColorScheme(.dark)
    }
}
