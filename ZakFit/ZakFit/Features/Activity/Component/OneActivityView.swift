//
//  OneActivityView.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct OneActivityView: View {
    var activity: Activity
    var body: some View {
        HStack{
            ZStack{
                Image(activity.getEnumType().image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                Color.black.opacity(0.5)
                
                Text(activity.getEnumType().rawValue
                )
                .font(.custom("Quicksand", size: 24))
                .bold()
                .foregroundStyle(.backgroundApp)
            }
            .frame(width: 180, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading){
                HStack{
                    Image(.calendrier)
                    Text(activity.date.toDate() ?? Date(), style: .date)
                }
                HStack{
                    Image(.montre)
                    Text("\(activity.duration) min")
                }
                HStack{
                    Image(.flamme)
                    Text("\(activity.cal) kcal")
                }
            }
        }
        .padding(15)
        .background(.secondaire)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
    }
}

#Preview {
    OneActivityView(activity: Activity(id: UUID(), sport: "musculation", date: "2025-12-03", cal: 300, duration: 31))
}
