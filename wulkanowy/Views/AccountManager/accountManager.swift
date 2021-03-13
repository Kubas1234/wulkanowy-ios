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
    @State private var accounts: [String] = [""]
    @State private var actualId: String = "0"
    
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
    
    private func openEditAccount(id: String) {
        let keychain = Keychain()
        keychain["editAccountId"] = id
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
        self.actualId = "\(id)"
        keychain["actualAccountEmail"] = "\(accountJSON["account"]["UserName"])"
        
        let apiResponseRequest = apiRequest(endpointURL: "\(RestURL)", id: id)
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
        
        accounts = getStudentsNames()
    }
    
    private func getUsername(student: JSON) -> String {
        if("\(student["customUsername"])" == "null") {
            return "\(student["account"]["UserName"])"
        } else {
            return "\(student["customUsername"])"
        }
    }
    
    var body: some View {
        if(isLogged == true) {
            VStack {
                Form {
                    Section(header: Text("chooseAccount")
                                .font(.title)) {
                        ForEach(accounts, id: \.self) { student in
                            let keychain = Keychain()
                            HStack {
                                let studentString = "\(keychain[student] ?? "{}")"
                                let data: Data = Data(studentString.utf8)
                                let studentJSON = try! JSON(data: data)
                                let studentEmail = getUsername(student: studentJSON)
                                
                                Button("\(studentEmail)") { setActualAccount(id: student) }
                                    .foregroundColor(Color("customControlColor"))
                                    .aspectRatio(contentMode: .fit)
                                if("\(actualId)" == "\(student)") {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.green)
                                }
                                Spacer()
                                let image = Image(uiImage: UIImage(systemName: "ellipsis")!)
                                    .renderingMode(.template)
                                
                                Button("\(image)") { openEditAccount(id: student) }
                                    .sheet(isPresented: $showEditAccountModal, onDismiss: {
                                        }) {
                                            AccountCardView()
                                        }
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }.onAppear {
                let keychain = Keychain()
                self.accounts = getStudentsNames()
                self.actualId = "\(keychain["actualAccountId"] ?? "0")"
            }
        } else {
            Spacer()
            Text("No accounts added")
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


struct AccountManagerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AccountManagerView()
        }
        .preferredColorScheme(.dark)
    }
}
