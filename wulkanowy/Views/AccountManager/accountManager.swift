//
//  accountManager.swift
//  wulkanowy
//
//  Created by Tomasz on 04/03/2021.
//

import SwiftUI
import KeychainAccess
import SwiftyJSON
import Sdk

struct AccountManagerView: View {
    @State private var showLoginModal = false
    @State private var showEditAccountModal = false
    @AppStorage("isLogged") private var isLogged: Bool = false
    
    private func getStudentsNames() -> [String] {
        //getting all accounts
        let keychain = Keychain()
        let allAccounts: String! = keychain["allAccounts"] ?? "[]"
        
        //parsing allAccounts to array
        var allAccountsArray: [String] = []
        if(allAccounts != "[]"){
            let data = Data(allAccounts.utf8)
            do {
                let ids = try JSONSerialization.jsonObject(with: data) as! [Int]
                for id in ids {
                    allAccountsArray.append("\(id)")
                }
            } catch {
                print(error)
            }
        }
        
        return allAccountsArray
    }
    
    private func addAccount() {
        self.showLoginModal = true
    }
    
    private func openEditAccount() {
        self.showEditAccountModal = true
    }
    
    private func getJsonFromString(body: String) -> JSON {
        let data = Data(body.utf8)
        
        let json = try! JSON(data: data)
        return json
    }
    
    private func setActualAccount(id: String) {
        let keychain = Keychain()
        let accountData = keychain["\(id)"] ?? "{}"
        let data: Data = Data(accountData.utf8)
        let accountJSON = try! JSON(data: data)
        let RestURL = "\(accountJSON["account"]["RestURL"])api/mobile/register/hebe"
        keychain["actualAccountId"] = "\(id)"
        keychain["actualAccountEmail"] = "\(accountJSON["account"]["UserName"])"
        
        let apiResponseRequest = apiRequest(endpointURL: "\(RestURL)")
        let session = URLSession.shared
        session.dataTask(with: apiResponseRequest) { (data, response, error) in
            if let error = error {
                // Handle HTTP request error
                print(error)
            } else if let data = data {
                // Handle HTTP request response
                let responseBody = String(data: data, encoding: String.Encoding.utf8)
                
                keychain["actualStudentHebe"] = "\(responseBody!)"
                
            } else {
                // Handle unexpected error
            }
        }.resume()
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("chooseAccount")
                            .font(.title)) {
                    ForEach(getStudentsNames(), id: \.self) { student in
                        let keychain = Keychain()
                        HStack {
                            let studentString = "\(keychain[student] ?? "{}")"
                            let data: Data = Data(studentString.utf8)
                            let studentJSON = try! JSON(data: data)
                            let studentEmail = "\(studentJSON["account"]["UserName"])"
                            Button("\(studentEmail)") { setActualAccount(id: student) }
                                .foregroundColor(Color("customControlColor"))
                            if("\(keychain["actualAccountId"] ?? "0")" == "\(student)") {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.green)
                            }
                            Spacer()
                            let image = Image(systemName: "pencil")
                            Button("\(image)") { openEditAccount() }
                                .sheet(isPresented: $showEditAccountModal, onDismiss: {
                                    }) {
                                        EditAccountView()
                                    }
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            Spacer()
            Button("addAccount") {addAccount()}
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor.opacity(0.1))
                .cornerRadius(12)
                .buttonStyle(BorderlessButtonStyle())
                .padding()
                .sheet(isPresented: $showLoginModal, onDismiss: {
                    }) {
                        LoginView()
                    }
        }
    }
}


struct AccountManagerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AccountManagerView()
        }
        .preferredColorScheme(.dark)
    }
}
