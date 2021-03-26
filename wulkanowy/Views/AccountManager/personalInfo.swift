//
//  personalInfo.swift
//  wulkanowy
//
//  Created by Tomasz on 11/03/2021.
//

import SwiftUI
import KeychainAccess
import Sdk
import SwiftyJSON

struct PersonalInfoView: View {    
    var body: some View {
        Text("Here is personal info (in my imagination)")
    }
}



struct PersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonalInfoView()
        }
        .preferredColorScheme(.dark)
    }
}

