//
//  ActivityView.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct ActivityView: View {
    @State var activityVM = ActivityViewModel()
    @State var isShowingSheet: Bool = false
    var body: some View {
        ZStack{
            Color.backgroundApp.ignoresSafeArea()
            
            
            ScrollView {
                VStack{
                    HStack{
                        Spacer()

                      
                        Button(action: {
                            isShowingSheet.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .padding(10)
                                .frame(width: 40, height: 40)
                                .background(.greenApp)
                                .foregroundStyle(.backgroundApp)
                                .clipShape(Circle())
                        })
                        
                    }
                    .padding()
                    
                    ForEach(activityVM.activitys, id: \.id){activity in
                        
                        OneActivityView(activity: activity)
                        
                    }
                }
                .task{
                    await activityVM.getActivity()
                }
                
            }
            
            .sheet(isPresented: $isShowingSheet) {
                
                Task {
                    await reloadActivity()
                }
            } content: {
                AddActivityView(isPresented: $isShowingSheet)
            }
        }.environment(activityVM)
    }
    
    private func reloadActivity() async {
        await activityVM.getActivity()
    }
}

#Preview {
    ActivityView(activityVM: ActivityViewModel())
}
