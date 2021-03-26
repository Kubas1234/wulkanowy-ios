//
//  OnboardingView.swift
//  wulkanowy
//
//  Created by Karol Zientek on 12/02/2021.
//
import SwiftUI

fileprivate struct InformationDetailView: View {
    var title: LocalizedStringKey = ""
    var subtitle: LocalizedStringKey = ""
    var imageName: String = ""
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.system(size: 50))
                .font(.largeTitle)
                .frame(width: 50)
                .foregroundColor(.accentColor)
                .padding()
                .accessibility(hidden: true)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)
                    .lineLimit(2)
                
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top)
    }
}

struct OnboardingView: View {
    
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
    
    var body: some View {
            VStack() {
                Spacer()
                Image("wulkanowy")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 92)
                    .foregroundColor(.accentColor)
                    .padding(.bottom)
                
                Text("onboardingTitle")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(height: 100)
                
                Spacer()
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        InformationDetailView(title: "notificationsOnboarding", subtitle: "notificationsOnboardingContent", imageName: "bell")
                        InformationDetailView(title: "messagesOnboarding", subtitle: "messagesOnboardingContent", imageName: "envelope")
                        InformationDetailView(title: "fast", subtitle: "fastContent", imageName: "hare")
                    }.multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                Spacer()
                Button("continueButton") { needsAppOnboarding = false }
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(12)
            }.padding()
    }
}

struct WulkanowyCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView().previewLayout(.fixed(width: 320, height: 640))
        }
    }
}
