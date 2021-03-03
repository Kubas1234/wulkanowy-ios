//
//  notes.swift
//  wulkanowy
//
//  Created by Tomasz on 26/02/2021.
//

import SwiftUI

struct NotesView: View {
    @State private var showModal = false
    @AppStorage("isLogged") private var isLogged: Bool = false
    
    var body: some View {
        NavigationView {
            if(isLogged == false){
                VStack {
                    Text("You are not logged in (notes)")
                    Button("Log in") {self.showModal = true}
                        .sheet(isPresented: $showModal, onDismiss: {
                                    print(self.showModal)
                                }) {
                                    LoginView()
                                }
                }.padding()
            } else {
                Text("Here is notes (in my imagination)")
            }
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
