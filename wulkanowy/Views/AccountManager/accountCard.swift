//
//  accountCard.swift
//  wulkanowy
//
//  Created by Tomasz on 05/03/2021.
//

import SwiftUI
import KeychainAccess
import SwiftyJSON
import Sdk

struct AccountCardView: View {
    @Environment(\.presentationMode) var presentation
    @State private var account: JSON = []
    @State private var username: String = ""
    @State private var showAlert = false
    @State private var hebe: JSON = []
    @State private var displayStudents: Array<String> = Array()
    @State private var selectedStudent: String = ""
    @State private var studentSchool = ""
    
    let id: String
    let keychain = Keychain()
    
    private func saveNewUsername(newUsername: String) {
        var accountJSON = self.account
        accountJSON["customUsername"].stringValue = "\(newUsername)"
        keychain[self.id] = "\(accountJSON)"
        getAccount()
        getUsername()
    }
    
    private func alert() {
        let alert = UIAlertController(title: "Zmiana nazwy", message: "Tu wpisz swoją nową nazwę konta", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = username
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in let textField = alert.textFields![0]
                            let newUsername = "\(textField.text ?? "\(username)")"
                            saveNewUsername(newUsername: newUsername)})
        showAlert(alert: alert)
    }

    func showAlert(alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
        }
    }

    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive}
        .compactMap {$0 as? UIWindowScene}
        .first?.windows.filter {$0.isKeyWindow}.first
    }

    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }

    private func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
    
    init() {
        self.id = keychain["editAccountId"] ?? "0"
    }
    
    private func getActualStudentName() -> String {
        let account = keychain[self.id] ?? "0"
        let data: Data = Data(account.utf8)
        let accountJSON = try! JSON(data: data)
        let actualStudentId = Int("\(accountJSON["actualStudent"])") ?? 0
        
        return "\(hebe["Envelope"][actualStudentId]["Login"]["DisplayName"])"
    }
    
    private func getStudents() -> Array<String> {
        var i: Int = 0
        var displayStudentsFunc: Array<String> = Array()
        while true {
            if (String(describing: hebe["Envelope"][i]) == "null") {
                break
            }
            else {
                displayStudentsFunc.append(String(describing: hebe["Envelope"][i]["Login"]["DisplayName"]))
                i += 1
            }
        }
        return displayStudentsFunc
    }
    
    private func getAccount() {
        let account = "\(keychain[self.id] ?? "{}")"
        let data: Data = Data(account.utf8)
        self.account = try! JSON(data: data)
    }
    
    private func getUsername() {
        if("\(account["customUsername"])" == "null") {
            username = "\(account["account"]["UserName"])"
        } else {
            username = "\(account["customUsername"])"
        }
    }
    
    private func getSchoolName() -> String {
        let actualStudent = Int("\(account["actualStudent"])") ?? 0
        return "\(hebe["Envelope"][actualStudent]["Unit"]["DisplayName"])"
    }
    
    private func done() {
        presentation.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    let pencilSymbol = Image(systemName: "pencil")
                    Button("\(pencilSymbol)") { alert() }
                        .font(.system(size: 25))
                        .padding()
                        .multilineTextAlignment(.trailing)
                }
                Spacer()
                Image(systemName: "person.circle")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 92)
                    .foregroundColor(.accentColor)
                    .padding(.bottom)
                Text("\(username)")
                    .font(.title)
                Spacer()
                Text(self.studentSchool)
                    .fontWeight(.light)
                
                
                Form {
                    Section(header: Text("Aktualny uczeń")) {
                        HStack {
                            Text("\(selectedStudent)")
                            Spacer()
                            Picker(selection: $selectedStudent, label: Image(systemName:"pencil")) {
                                ForEach(displayStudents, id: \.self) { student in
                                    Text(student)
                                }
                            }.pickerStyle(MenuPickerStyle())
                        }
                    }
                    
                    Section {
                        NavigationLink(destination: PersonalInfoView()) {
                            Label("Dane osobowe", systemImage: "person")
                                .accessibility(label: Text("Dane osobowe"))
                        }
                        NavigationLink(destination: ResidenceInfoView()) {
                            Label("Dane adresowe", systemImage: "house")
                                .accessibility(label: Text("Dane adresowe"))
                        }
                        NavigationLink(destination: ContactView()) {
                            Label("Kontakt", systemImage: "phone")
                                .accessibility(label: Text("Kontakt"))
                        }
                        NavigationLink(destination: FamilyView()) {
                            Label("Rodzina", systemImage: "person.2")
                                .accessibility(label: Text("Rodzina"))
                        }
                    }
                }
                
                Spacer()
                Button("Done") { done() }
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(12)
            }.padding()
            .onAppear {
                getAccount()
                getUsername()
                self.hebe = getHebe(id: self.id, account: self.account)
                self.displayStudents = getStudents()
                self.studentSchool = getSchoolName()
                self.selectedStudent = getActualStudentName()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}



struct AccountCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AccountCardView()
        }
        .preferredColorScheme(.dark)
    }
}

