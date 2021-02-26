//
//  notes.swift
//  wulkanowy
//
//  Created by Tomasz on 26/02/2021.
//

import SwiftUI

struct NotesView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        Text("You are not logged in (notes)")
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                        }
                    }.padding()
                }
    }
}



struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotesView()
        }
        .preferredColorScheme(.dark)
    }
}
