//
//  Title OnBoarding.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import SwiftUI

struct Title_OnBoarding: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Pour mieux vous connaître.")
                .font(.custom("Quicksand", size: 26))
                .bold()
            
            Text("Afin de personnaliser au mieux votre suivi, nous avons besoin de quelques informations vous concernant.")
        }
            .foregroundStyle(.text)
    }
}

#Preview {
    Title_OnBoarding()
}
