//
//  TextFieldComponentView.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import SwiftUI

struct TextFieldComponentView: View {
    var placeholder: String
    
    @Binding var text: String
    var secured : Bool = false
    var body: some View {
        
        if secured{
            SecureField(placeholder, text: $text)
                .padding()
                .background(.secondaire)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
        }
        
        else{
            TextField(placeholder, text: $text)
                .padding()
                .background(.secondaire)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
        }
    }
}

#Preview {
    TextFieldComponentView(placeholder: "mot de passe", text: .constant(""))
}
