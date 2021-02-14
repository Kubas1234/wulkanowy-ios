//
//  LoginView.swift
//  wulkanowy
//
//  Created by Karol Zientek on 13/02/2021.
//

import SwiftUI

struct LoginView: View {
    
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
    
    @State private var token: String = ""
    
    
    var body: some View {
        VStack {
            Image("wulkanowy-svg")
                .resizable()
                .foregroundColor(Color("PrimaryColor"))
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            Text("login.login")
                .font(.largeTitle)
                .padding(.bottom, 30)
            
            CustomTextFieldView(placeholder: "login.token", text: "")
            
            CustomTextFieldView(placeholder: "login.symbol", text: "")
            
            CustomTextFieldView(placeholder: "login.pin", text: "")
            
            Spacer()
            
            CustomButtonView(action: {
                print("Works")
            }, title: "login.login")
        }
        .padding([.top, .horizontal], 20)
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
