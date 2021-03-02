//
//  grades.swift
//  wulkanowy
//
//  Created by Tomasz on 24/02/2021.
//

import SwiftUI

struct GradesView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        Text("You are not logged in (grades)")
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                        }
                    }.padding()
                }
    }
}



struct GradesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GradesView()
        }
        .preferredColorScheme(.dark)
    }
}
