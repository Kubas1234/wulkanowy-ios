//
//  navigation.swift
//  wulkanowy
//
//  Created by Tomasz on 23/02/2021.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        TabView() {
            NavigationView {
                DashboardView()
                    .navigationBarItems(trailing: NavigationLink(destination: AccountManagerView()) {
                        Image(systemName: "person.circle")
                    })
                        }
                .tabItem {
                Label("dashboardButton", systemImage: "rectangle.on.rectangle")
                    .accessibility(label: Text("dashboardButton"))
            }
            
            NavigationView {
                GradesView()
                    .navigationBarItems(trailing: NavigationLink(destination: AccountManagerView()) {
                        Image(systemName: "person.circle")
                    })
                        }
                .tabItem {
                Label("gradesButton", systemImage: "rosette")
                    .accessibility(label: Text("gradesButton"))
            }

            NavigationView {
                ExamsView()
                    .navigationBarItems(trailing: NavigationLink(destination: AccountManagerView()) {
                        Image(systemName: "person.circle")
                    })
                        }
                .tabItem {
                Label("examsButton", systemImage: "calendar")
                    .accessibility(label: Text("examsButton"))
            }
            
            NavigationView {
                HomeworksView()
                    .navigationBarItems(trailing: NavigationLink(destination: AccountManagerView()) {
                        Image(systemName: "person.circle")
                    })
                        }
                .tabItem {
                Label("homeworkButton", systemImage: "note.text")
                    .accessibility(label: Text("homeworkButton"))
            }
            
            MoreView()
            .tabItem {
                Label("moreButton", systemImage: "ellipsis.circle")
                    .accessibility(label: Text("moreButton"))
            }
        }
    }
}


struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationBarView()
        }
        .preferredColorScheme(.dark)
    }
}

