//
//  ContentView.swift
//  wulkanowy
//
//  Created by Mikołaj on 25/10/2020.
//

import SwiftUI
import KeychainAccess
import SwiftyJSON

enum AvailableEndpoints: String, CaseIterable {
    case vulcan = "Vulcan"
    case fakelog = "Fakelog"
}

open class Navigation: ObservableObject {
    let window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }
}

struct LoginView: View {
    @StateObject var vulcan: VulcanStore = VulcanStore.shared
    
    @State private var token: String = ""
    @State private var symbol: String = ""
    @State private var pin: String = ""
    @State private var deviceModel: String = ""
    
    @State private var clicked: Bool = false
    @State private var buttonValue = String(format: NSLocalizedString("loginButton", comment: "loginButton"))
    @State private var loginStatus: String = ""
    @State private var willMoveToNextScreen = false
    @State private var success = false
    @State private var showingAlert = false
    
    let cellHeight: CGFloat = 55
    let cornerRadius: CGFloat = 12
    let cellBackground: Color = Color(UIColor.systemGray5).opacity(0.5)
    
    let nullColor: Color = Color.accentColor.opacity(0.4)
    
    private func login() {
        clicked = true
        if(token != "" && symbol != "" && pin != "" && deviceModel != "") {
            vulcan.login(token: token, symbol: symbol, pin: pin, deviceModel: deviceModel) { error in
                    if let error = error {
                        print("error: \(error)")
                        switch("\(error)"){
                        case "wrongToken":
                            buttonValue = String(format: NSLocalizedString("\(error)", comment: "loginButton"))
                            
                        case "wrongSymbol":
                            buttonValue = String(format: NSLocalizedString("\(error)", comment: "loginButton"))
                        
                        case "wrongPin":
                            buttonValue = String(format: NSLocalizedString("\(error)", comment: "loginButton"))
                            
                        case "deviceExist":
                            showingAlert.toggle()
                            success = false
                        
                        default:
                            buttonValue = String(format: NSLocalizedString("invalidData", comment: "loginButton"))
                        }
                    } else {
                        print("success")
                        success = true
                    }
            }
        }
    }
    
    private func setColor(input: String) -> Color {
        if(clicked == true){
            switch(input) {
            case "token":
                if (token == "") {
                    return nullColor
                } else {
                    return cellBackground
                }
                
            case "symbol":
                if (symbol == "") {
                    return nullColor
                } else {
                    return cellBackground
                }
                
            case "pin":
                if (pin == "") {
                    return nullColor
                } else {
                    return cellBackground
                }
                
            case "deviceName":
                if (deviceModel == "") {
                    return nullColor
                } else {
                    return cellBackground
                }
                
            default:
                return cellBackground
            }
        } else {
            return cellBackground
        }
    }
    
    var body: some View {
        if(success == true) {
            ChooseStudentView()
        }
        else
        {
            VStack {
                Spacer()
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
                
                Spacer()
                
                TextField("token", text: $token)
                    .autocapitalization(.none)
                    .font(Font.body.weight(Font.Weight.medium))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: cellHeight)
                    .background(cellBackground)
                    .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(setColor(input: "token"), lineWidth: 2)
                        )
                
                TextField("symbol", text: $symbol)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(Font.body.weight(Font.Weight.medium))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: cellHeight)
                    .background(cellBackground)
                    .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(setColor(input: "symbol"), lineWidth: 2)
                        )
                
                TextField("pin", text: $pin)
                    .keyboardType(.numberPad)
                    .autocapitalization(.none)
                    .font(Font.body.weight(Font.Weight.medium))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: cellHeight)
                    .background(cellBackground)
                    .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(setColor(input: "pin"), lineWidth: 2)
                        )
                
                TextField("deviceName", text: $deviceModel)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(Font.body.weight(Font.Weight.medium))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: cellHeight)
                    .background(cellBackground)
                    .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(setColor(input: "deviceName"), lineWidth: 2)
                        )
                
                Spacer()
                
                Button(buttonValue) {login()}
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: cellHeight)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(cornerRadius)
                
            }.padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("accountRegistered"), message: Text("accountRegisteredContent"), dismissButton: .default(Text("OK")))}
                Spacer()
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
        .preferredColorScheme(.dark)
    }
}
