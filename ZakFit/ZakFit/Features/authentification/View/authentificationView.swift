//
//  authentificationView.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import SwiftUI

struct authentificationView: View {
    @State var isConnexion: Bool = true
    var body: some View {
        if isConnexion{
            ConnexionView(isConnexion: $isConnexion)
        }
        
        else {
            InscriptionView(isConnexion: $isConnexion)
        }
    }
}

#Preview {
    authentificationView()
}
