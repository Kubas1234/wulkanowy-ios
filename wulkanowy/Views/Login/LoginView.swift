//
//  LoginView.swift
//  wulkanowy
//
//  Created by Karol Zientek on 13/02/2021.
//

import SwiftUI

struct LoginView: View {
    
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .sheet(isPresented: $needsAppOnboarding) {
                OnboardingView()
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
