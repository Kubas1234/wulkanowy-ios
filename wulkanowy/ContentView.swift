//
//  ContentView.swift
//  wulkanowy
//
//  Created by Mikołaj on 25/10/2020.
//

import SwiftUI

enum AvailableEndpoints: String, CaseIterable {
    case vulcan = "Vulcan"
    case fakelog = "Fakelog"
}


struct ContentView: View {
    
    @StateObject var vulcan: VulcanStore = VulcanStore.shared
    
    @State private var token: String = ""
    @State private var symbol: String = ""
    @State private var pin: String = ""
    @State private var deviceModel: String = ""
    
    let cellHeight: CGFloat = 55
    let cornerRadius: CGFloat = 12
    let cellBackground: Color = Color(UIColor.systemGray6).opacity(0.5)
    
    private func login() {
        vulcan.login(token: token, symbol: symbol, pin: pin, deviceModel: deviceModel) { error in
                if let error = error {
                    print("error: \(error)")
                } else {
                    print("success")
                }
        }
    }
    
    
    var body: some View {
        VStack {
            VStack {
                Image("wulkanowy")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 92)
                    .foregroundColor(.accentColor)
                    .padding(.bottom)
                
                Text("loginTitle")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .padding(.top, 50)
            .padding(.bottom, -50)
            
            Spacer()
            
            TextField("token", text: $token)
                .autocapitalization(.none)
                .font(Font.body.weight(Font.Weight.medium))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: cellHeight)
                .background(cellBackground)
                .cornerRadius(cornerRadius)
            
            TextField("symbol", text: $symbol)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(Font.body.weight(Font.Weight.medium))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: cellHeight)
                .background(cellBackground)
                .cornerRadius(cornerRadius)
            
            TextField("pin", text: $pin)
                .keyboardType(.numberPad)
                .autocapitalization(.none)
                .font(Font.body.weight(Font.Weight.medium))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: cellHeight)
                .background(cellBackground)
                .cornerRadius(cornerRadius)
            
            TextField("Device name", text: $deviceModel)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(Font.body.weight(Font.Weight.medium))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: cellHeight)
                .background(cellBackground)
                .cornerRadius(cornerRadius)
            
            Spacer()
            
            Button("loginButton") {login()}
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: cellHeight)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor.opacity(0.1))
                .cornerRadius(cornerRadius)
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                
        }
        .preferredColorScheme(.light)
    }
}
