//
//  CustomButtonView.swift
//  wulkanowy
//
//  Created by Karol Zientek on 12/02/2021.
//
import SwiftUI

struct CustomButtonView: View {
    
    var action: () -> ()
    var title: String
    
    var body: some View {
        Button(action: action, label: {
            Text(LocalizedStringKey(title))
        })
        .padding(10)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color("PrimaryColor"))
        .foregroundColor(.white)
        .font(.title)
        .cornerRadius(20)
    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(action: {
            print("Button tapped!")
        }, title: "Test")
            .previewLayout(.sizeThatFits)
    }
}
