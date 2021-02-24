//
//  homework.swift
//  wulkanowy
//
//  Created by Tomasz on 24/02/2021.
//

import SwiftUI

struct HomeworksView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        Text("You are not logged in (homeworks)")
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                        }
                    }.padding()
                }
    }
}



struct HomeworksView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeworksView()
        }
        .preferredColorScheme(.dark)
    }
}
