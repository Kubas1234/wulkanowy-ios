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
    @State private var showModal = false
    @AppStorage("isLogged") private var isLogged: Bool = false
    
    
    private func getStudentsNames() -> [String] {
        //getting allStudentsKeys
        let keychain = Keychain()
        let allStudentsKeys: String! = keychain["allStudentsKeys"] ?? "[]"
        
        //parsing allStudentsKeys to array
        var allStudents: [String] = []
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
        
        return allStudents
    }
    
    private func addAccount() {
        self.showModal = true
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
                        Text(student)
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
                .sheet(isPresented: $showModal, onDismiss: {
                    print(self.showModal)
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
