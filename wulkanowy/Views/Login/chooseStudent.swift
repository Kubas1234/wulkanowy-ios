//
//  chooseStudent.swift
//  wulkanowy
//
//  Created by Tomasz on 02/03/2021.
//

import Foundation
import SwiftUI
import KeychainAccess
import SwiftyJSON

struct ChooseStudentView: View {
    @Environment(\.presentationMode) var presentation
    @AppStorage("isLogged") private var isLogged: Bool = false
    
    let keychain = Keychain()
    var displayStudents: Array<String> = Array()
    
    @State private var selectedStudent: String = ""
    
    init() {
        let responseBody = keychain["students"]
        let json = getJsonFromString(body: responseBody!)
        var i: Int = 0
        while true {
            if (String(describing: json["Envelope"][i]) == "null") {
                break
            }
            else {
                displayStudents.append(String(describing: json["Envelope"][i]["Login"]["DisplayName"]))
                displayStudents.append("dupa")
                i += 1
            }
        }
        selectedStudent = displayStudents[0]
    }
    
    private func getJsonFromString(body: String) -> JSON {
        let data = Data(body.utf8)
        
        let json = try! JSON(data: data)
        return json
    }
    
    private func saveStudent() {
        isLogged = true
        let responseBody = keychain["students"]
        let json = getJsonFromString(body: responseBody!)
        var i: Int = 0
        while true {
            if (String(describing: json["Envelope"][i]["Login"]["DisplayName"]) == selectedStudent) {
                keychain["acctualStudent"] = "\(json["Envelope"][i])"
                break
            }
            i += 1
        }
        isLogged = true
        presentation.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(selectedStudent)
            Text("Wybierz ucznia")
                .font(.title)
                .padding(.top)
            Picker(selection: $selectedStudent, label: Text("Wybierz ucznia:")) {
                ForEach(displayStudents, id: \.self) { student in
                    Text(student)
                }
            }
            Spacer()
            //NavigationLink(destination: NavigationBarView()){
            Button("Zarejestruj") {saveStudent()}
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor.opacity(0.1))
                .cornerRadius(12)
            //}
            
        }.padding()
    }
}



struct ChooseStudentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChooseStudentView()
        }
        .preferredColorScheme(.dark)
    }
}
