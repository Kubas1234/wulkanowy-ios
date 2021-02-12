//
//  OnboardingView.swift
//  wulkanowy
//
//  Created by Karol Zientek on 12/02/2021.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
            VStack(spacing: 20) {
                Spacer()
                Image("wulkanowy-svg")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .top)
                    .foregroundColor(Color("OnboardingColor"))
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
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
            .onAppear {
                withAnimation(.easeOut(duration: 0.5)) {
                    isAnimating = true
                }
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
