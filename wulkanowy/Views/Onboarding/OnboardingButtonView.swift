//
//  OnboardingButtonView.swift
//  wulkanowy
//
//  Created by Karol Zientek on 12/02/2021.
//

import SwiftUI

struct OnboardingButtonView: View {
    
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true
    
    var body: some View {
        Button(action: {
            needsAppOnboarding = false
        }, label: {
            Text("onboarding.continue")
        })
        .padding(10)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color("OnboardingColor"))
        .foregroundColor(.white)
        .font(.title)
        .cornerRadius(20)
    }
}

struct OnboardingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingButtonView()
            .previewLayout(.sizeThatFits)
    }
}
