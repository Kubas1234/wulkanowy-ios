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
                Label("dashboardButton", systemImage: "rectangle.on.rectangle")
                    .accessibility(label: Text("Dashboard"))
            }

            GradesView()
            .tabItem {
                Label("gradesButton", systemImage: "rosette")
                    .accessibility(label: Text("Grades"))
            }
            
            ExamsView()
            .tabItem {
                Label("examsButton", systemImage: "calendar")
                    .accessibility(label: Text("Exams"))
            }
            
            HomeworksView()
            .tabItem {
                Label("homeworkButton", systemImage: "note.text")
                    .accessibility(label: Text("Homework"))
            }
            
            MoreView()
            .tabItem {
                Label("moreButton", systemImage: "ellipsis.circle")
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

