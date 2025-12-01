//
//  TextFieldDoubleView.swift
//  ZakFit
//
//  Created by Emma on 30/11/2025.
//

import SwiftUI

struct TextFieldDoubleView: View {
    @Binding var number: Double
    var text: String
    var body: some View {
        HStack(spacing: 0){
           
                TextField("age", value: $number , format: .number)
            
            Text(text)
        }
        .padding(12)
        .frame(width: 90)
            .background(.secondaire)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
    }
}

#Preview {
    TextFieldDoubleView(number: .constant(43.5), text: "Kg")
}
