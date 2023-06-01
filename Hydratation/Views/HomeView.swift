//
//  HomeView.swift
//  Hydratation
//
//  Created by Arthur dubois on 17/05/2023.
//

import SwiftUI

extension Binding where Value == Int {
    public func float() -> Binding<Float> {
        return Binding<Float>(get:{ Float(self.wrappedValue) },
            set: { self.wrappedValue = Int($0)})
    }
}

struct HomeView: View {
    
    @State var progressValue: Float = 0.0
    
    @EnvironmentObject var dailyData: DailyQuantityViewModel
    
    
    @AppStorage("customQuantity") private var customQuantity = 0
    @AppStorage("userId") private var utilisateur_id = 0
    @AppStorage("userMail") private var utilisateur_mail = ""
    
    @State private var showingPopover = false
    
    var body:  some View {
        ZStack {
            Color.gray
                .opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            
                VStack {
                    switch dailyData.state {
                    case.success(let dailyQuantity):
                    ProgressBar(progress: Float(dailyQuantity.quantite_ml)/Float(customQuantity))
                        .frame(width: 150.0, height: 150.0)
                        .padding(40.0)
                    
                    Text("Your goal is to drunk \(customQuantity)")
                        .padding()
                    
                    
                    
                    Button(action: {
                        showingPopover = true
                    }) {
                        HStack {
                            Image(systemName: "plus.rectangle.fill")
                            Text("Increment")
                        }
                        .padding(15.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15.0)
                                .stroke(lineWidth: 2.0)
                        )
                    }
                    .popover(isPresented: $showingPopover) {
                        FavoritesView(presentMe: $showingPopover)
                            .onDisappear {
                                        
                                        Task {
                                            await dailyData.getQuantity(userId: utilisateur_id)
                                        }
                                    }
                            
                    }
                    .padding()
                    
                    
                    
                    Text("you have drunk : \(dailyQuantity.quantite_ml)mL")
                        .padding()
                    case .loading:
                        ProgressView()
                    default:
                        EmptyView()
                    }
                }
                .task {
                    await dailyData.getQuantity(userId: utilisateur_id)
                }
            
        }
        
    }
    
}

struct ProgressBar: View {
    var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("yellow"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            Text(String(format: "%.0f %%", (self.progress )*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(QuantityViewModel())
    }
}
