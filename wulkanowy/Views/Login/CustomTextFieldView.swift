//
//  CustomTextFieldView.swift
//  wulkanowy
//
//  Created by Karol Zientek on 13/02/2021.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    var placeholder: String
    
    @State var text: String
    
    var body: some View {
        TextField(LocalizedStringKey(placeholder), text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.secondary.opacity(0.15)))
            .keyboardType(.alphabet)
            .disableAutocorrection(true)
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView(placeholder: "Token", text: "").previewLayout(.sizeThatFits)
    }
}
