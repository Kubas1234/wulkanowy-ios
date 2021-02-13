//
//  OnboardingView.swift
//  wulkanowy
//
//  Created by Karol Zientek on 12/02/2021.
//

import SwiftUI

struct OnboardingView: View {
    
    var body: some View {
            VStack(spacing: 20) {
                Spacer()
                Image("wulkanowy-svg")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .top)
                    .foregroundColor(Color("OnboardingColor"))
                VStack(spacing: 20) {
                    Text("onboarding.description.title")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Text("onboarding.description.content")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 20)
                Spacer()
                OnboardingButtonView()
                    .padding()
            }
    }
}

struct WulkanowyCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView().previewLayout(.fixed(width: 320, height: 640))
        }
    }
}
