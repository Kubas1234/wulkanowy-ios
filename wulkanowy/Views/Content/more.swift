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
            Form {
                Section {
                    NavigationLink(destination: MessagesView()) {
                        Text("Messages")
                    }
                    NavigationLink(destination: NotesView()) {
                        Text("Notes and achievements")
                    }
                }
                
                Section {
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                    }
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }
                }
            }
            .navigationBarTitle("Wulkanowy - more", displayMode: .inline)
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
