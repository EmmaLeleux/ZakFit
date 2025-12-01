//
//  PopUpImageView.swift
//  ZakFit
//
//  Created by Emma on 01/12/2025.
//

import SwiftUI

struct PopUpImageView: View {
    @Binding var photoProfil: String
    @Binding var showPopUp: Bool
    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                ForEach(ImageEnum.allCases, id: \.self){ photo in
                    
                    Button(action:{
                        photoProfil = photo.lien
                        showPopUp.toggle()
                    }, label: {
                        AsyncImage(url: URL(string: photo.lien)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .background(.greenApp.opacity(0.4))
                                .clipShape(.circle)
                            
                        } placeholder: {
                            ProgressView()
                        }
                    })
                    
                }
            }
        }
        .padding()
        .background(.secondaire)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
    }
}

#Preview {
    PopUpImageView(photoProfil: .constant(""), showPopUp: .constant(true))
}
