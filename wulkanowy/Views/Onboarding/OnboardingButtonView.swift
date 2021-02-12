//
//  OnboardingButtonView.swift
//  wulkanowy
//
//  Created by Karol Zientek on 12/02/2021.
//

import SwiftUI

struct OnboardingButtonView: View {
    var body: some View {
        Button(action: {
            print("Exit the onboarding")
        }, label: {
            Text("onboarding.start")
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
