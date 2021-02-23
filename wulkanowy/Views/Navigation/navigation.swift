//
//  navigation.swift
//  wulkanowy
//
//  Created by Tomasz on 23/02/2021.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Grades", systemImage: "rosette")
                        .accessibility(label: Text("Grades"))
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

