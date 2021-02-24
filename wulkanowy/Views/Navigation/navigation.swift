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
            DashboardView()
            .tabItem {
                Label("Dashboard", systemImage: "rectangle.on.rectangle")
                    .accessibility(label: Text("Dashboard"))
            }

            GradesView()
            .tabItem {
                Label("Grades", systemImage: "rosette")
                    .accessibility(label: Text("Grades"))
            }
            
            ExamsView()
            .tabItem {
                Label("Exams", systemImage: "calendar")
                    .accessibility(label: Text("Exams"))
            }
            
            HomeworksView()
            .tabItem {
                Label("Homework", systemImage: "note.text")
                    .accessibility(label: Text("Homework"))
            }
            
            MoreView()
            .tabItem {
                Label("More", systemImage: "ellipsis.circle")
                    .accessibility(label: Text("More"))
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

