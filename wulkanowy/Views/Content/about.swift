//
//  about.swift
//  wulkanowy
//
//  Created by Tomasz on 26/02/2021.
//

import Foundation
import SwiftUI
import UIKit
import Combine
import MessageUI
import SwiftUIEKtensions

struct AboutView: View {
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false
    
    var body: some View {
        Form {
            Section {
                DisclosureGroup("App version") {
                    Text("You actually version is alpha 0.1")
                        .font(.system(.body, design: .monospaced))
                }
                
                DisclosureGroup("Contributors") {
                    HStack {
                        AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/55411338?s=460&v=4")!,
                                       placeholder: { Image(systemName: "circle.dashed") },
                                       image: { Image(uiImage: $0).resizable() })
                            .frame(width: 38, height: 38)
                        Link("Pengwius", destination: URL(string: "https://github.com/pengwius")!)
                            .foregroundColor(Color("customControlColor"))
                    }
                    
                    HStack {
                        AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/23171377?s=460&u=ce615ffdaaea96b191b1c27fb915fd18d25eaebd&v=4")!,
                                       placeholder: { Image(systemName: "circle.dashed") },
                                       image: { Image(uiImage: $0).resizable() })
                            .frame(width: 38, height: 38)
                        Link("rrroyal", destination: URL(string: "https://github.com/rrroyal")!)
                            .foregroundColor(Color("customControlColor"))
                    }
                    
                    HStack {
                        AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/20373275?s=400&u=a59e3ca4656a7113a0021682b6733c27e6742e73&v=4")!,
                                       placeholder: { Image(systemName: "circle.dashed") },
                                       image: { Image(uiImage: $0).resizable() })
                            .frame(width: 38, height: 38)
                        Link("Karol Z.", destination: URL(string: "https://github.com/szakes1")!)
                            .foregroundColor(Color("customControlColor"))
                    }
                }
                
                NavigationLink(destination: LicensesView()) {
                    Text("Licenses")
                }
                
                Link("FAQ", destination: URL(string: "https://wulkanowy.github.io/czesto-zadawane-pytania")!)
                    .foregroundColor(Color("customControlColor"))
                
                Link("Privacy policy", destination: URL(string: "https://wulkanowy.github.io/polityka-prywatnosci")!)
                    .foregroundColor(Color("customControlColor"))
            }
            Section {
                Link("Join the Discord serwer", destination: URL(string: "https://discord.com/invite/vccAQBr")!)
                    .foregroundColor(Color("customControlColor"))
                        
                Link("Facebook fanpage", destination: URL(string: "https://www.facebook.com/wulkanowy")!)
                    .foregroundColor(Color("customControlColor"))
                        
                Link("Reddit", destination: URL(string: "https://www.reddit.com/r/wulkanowy/")!)
                    .foregroundColor(Color("customControlColor"))
            }
            
            Section {
                Button(action: {
                            if MFMailComposeViewController.canSendMail() {
                                self.isShowingMailView.toggle()
                            } else {
                                print("Can't send emails from this device")
                            }
                            if result != nil {
                                print("Result: \(String(describing: result))")
                            }
                        }) {
                            HStack {
                                Text("Report a bug")
                                    .foregroundColor(Color("customControlColor"))
                            }
                        }
                        // .disabled(!MFMailComposeViewController.canSendMail())
                    }
                    .sheet(isPresented: $isShowingMailView) {
                        MailView(result: $result) { composer in
                            composer.setSubject("")
                            composer.setToRecipients(["wulkanowyinc@gmail.com"])
                        }
                    }
                
                Link("Homepage", destination: URL(string: "https://wulkanowy.github.io/")!)
                    .foregroundColor(Color("customControlColor"))
                
                Link("Github", destination: URL(string: "https://github.com/wulkanowy/wulkanowy-ios")!)
                    .foregroundColor(Color("customControlColor"))
                        
                Link("Donate us!", destination: URL(string: "https://www.paypal.com/paypalme/wulkanowy")!)
                    .foregroundColor(Color("customControlColor"))
        }
    }
}



struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AboutView()
        }
        .preferredColorScheme(.dark)
    }
}

