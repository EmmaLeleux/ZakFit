//
//  MealsView.swift
//  ZakFit
//
//  Created by Emma on 01/12/2025.
//

import SwiftUI

struct MealsView: View {
    @State private var date = Date()
    var body: some View {
        HStack{
            Spacer()
            
            
            DatePicker(selection: $date){
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .padding(14)
                    .background(.greenApp)
                    .clipShape(.circle)
                    .foregroundStyle(.backgroundApp)
            }
            
            Image(systemName: "calendar")
                      .font(.title3)
                      .overlay{ //MARK: Place the DatePicker in the overlay extension
                          DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: [.date]
                          )
                          .blendMode(.destinationOver) //MARK: use this extension to keep the clickable functionality
                          .onChange(of: date, perform: { value in
                              Text("")
                          })
                      }
            
        }
    }
}

#Preview {
    MealsView()
}
