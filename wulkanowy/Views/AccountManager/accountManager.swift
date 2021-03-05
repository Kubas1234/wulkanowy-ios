//
//  accountManager.swift
//  wulkanowy
//
//  Created by Tomasz on 04/03/2021.
//

import SwiftUI
import KeychainAccess
import SwiftyJSON

struct AccountManagerView: View {
    @State private var showLoginModal = false
    @State private var showEditAccountModal = false
    @AppStorage("isLogged") private var isLogged: Bool = false
    
    
    private func getStudentsNames() -> [String] {
        //getting allStudentsKeys
        let keychain = Keychain()
        let allStudentsKeys: String! = keychain["allStudentsKeys"] ?? "[]"
        
        //parsing allStudentsKeys to array
        var allStudents: [String] = []
        if(allStudentsKeys != "[]"){
            let data = Data(allStudentsKeys.utf8)
            do {
                let keys = try JSONSerialization.jsonObject(with: data) as! [String]
                for key in keys {
                    let student = keychain["student-\(key)"]
                    let data = Data(student!.utf8)
                    let studentParsed = try! JSON(data: data)
                    allStudents.append("\(studentParsed["Login"]["DisplayName"])")
                }
            } catch {
                print(error)
            }
        }
        
        return allStudents
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
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("chooseAccount")
                            .font(.title)) {
                    ForEach(getStudentsNames(), id: \.self) { student in
                        HStack {
                            Text(student)
                            Spacer()
                            let image = Image(systemName: "pencil")
                            Button("\(image)") { openEditAccount() }
                            .sheet(isPresented: $showEditAccountModal, onDismiss: {
                                    print(self.showEditAccountModal)
                                }) {
                                    EditAccountView()
                                }
                        }
                    }
                }
            }.padding(.bottom)
            Spacer()
            Button("addAccount") {addAccount()}
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor.opacity(0.1))
                .cornerRadius(12)
                .padding()
                .sheet(isPresented: $showLoginModal, onDismiss: {
                    print(self.showLoginModal)
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
