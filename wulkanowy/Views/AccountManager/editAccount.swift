//
//  editAccount.swift
//  wulkanowy
//
//  Created by Tomasz on 05/03/2021.
//

import SwiftUI

struct EditAccountView: View {
    @Environment(\.presentationMode) var presentation
    
    private func done() {
        presentation.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.circle")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 92)
                .foregroundColor(.accentColor)
                .padding(.bottom)
            Spacer()
            Button("Done") {done()}
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor.opacity(0.1))
                .cornerRadius(12)
        }
    }
}



struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditAccountView()
        }
        .preferredColorScheme(.dark)
    }
}

