//
//  RepartitionActivity.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct RepartitionActivity: View {
    @State var activityVM = ActivityViewModel()
    var listSportToday: [SportsEnum] {
            SportsEnum.allCases.filter { sport in
                activityVM.activitys.contains(where: { $0.sport == sport.rawValue })
            }
        }
    var body: some View {
        VStack(alignment: .leading) {
            Text("Répartition des\nactivités")
                .font(.custom("Quicksand", size: 16))
                .bold()
                .foregroundStyle(.greenApp)
                .padding(.bottom)
                .multilineTextAlignment(.leading)
            
            if !activityVM.activitys.isEmpty{
                
                NavigationLink(destination: {
                    ActivityView()
                }, label: {
                    ZStack {
                        
                        ForEach(listSportToday.enumerated(), id: \.offset){ index, sport in
                           
                            let count = activityVM.activitys.filter { $0.sport == sport.rawValue }.count
                                let pourcent = Double(count) / Double(activityVM.activitys.count)
                                
                                let previousPourcent = listSportToday.prefix(index).reduce(0.0) { total, prevSport in
                                        let prevCount = activityVM.activitys.filter { $0.sport == prevSport.rawValue }.count
                                        return total + (Double(prevCount) / Double(activityVM.activitys.count))
                                    }
                                
                                    Circle()
                                        .trim(from: 0, to: CGFloat(pourcent))
                                        .stroke(lineWidth: 15)
                                        .frame(width: 100, height: 100)
                                        .foregroundStyle(sport.couleur)
                                        .rotationEffect(Angle(degrees: -90 + previousPourcent * 360))
                                
                            
                            
                        }
                        
                        
                        
                        
                    }
                })
                
                .padding()
                
                ScrollView(.horizontal){
                    LazyHGrid(rows: [GridItem(.fixed(10)), GridItem(.fixed(10)), GridItem(.fixed(10))], content: {
                        ForEach(listSportToday, id: \.self){ sport in
                            
                            HStack{
                                Circle().fill(sport.couleur)
                                    .frame(width: 15, height: 15)
                                Text(sport.rawValue)
                                    .font(.system(size: 13))
                                    .bold()
                                Spacer()
                            }
                        }
                    })
                    
                }
                .frame(height: 60)
                .scrollIndicators(.hidden)
            }
            
            else{
                Text("Tu n'a pas encore\nd'activité aujourd'hui.")
                    .font(.callout)
            }
        }
        .padding()
        .frame(width: 162)
        .background(.secondaire)
        
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
        .task{
             activityVM.fetchActivitys(date: Date())
        }
    }
}

#Preview {
    RepartitionActivity()
}
