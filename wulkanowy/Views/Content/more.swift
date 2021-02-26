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
                        Label("messagesButton", systemImage: "envelope")
                            .accessibility(label: Text("messagesButton"))
                    }
                    NavigationLink(destination: NotesView()) {
                        Label("notesButton", systemImage: "graduationcap")
                            .accessibility(label: Text("notesButton"))
                    }
                }
                
                Section {
                    NavigationLink(destination: SettingsView()) {
                        Label("settingsButton", systemImage: "gear")
                            .accessibility(label: Text("settingsButton"))
                    }
                    NavigationLink(destination: AboutView()) {
                        Label("aboutButton", systemImage: "info.circle")
                            .accessibility(label: Text("aboutButton"))
                    }
                }
            }
            .navigationBarTitle("moreButton", displayMode: .inline)
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
