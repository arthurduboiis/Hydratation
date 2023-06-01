//
//  Statistique.swift
//  Hydratation
//
//  Created by Arthur dubois on 31/05/2023.
//

import SwiftUI
import Charts

struct Statistique: View {
    
    @EnvironmentObject var dailyData: DailyQuantityViewModel
    
    @AppStorage("userId") private var utilisateur_id = 0
    
    var body: some View {
        VStack {
            Text("Statistiques")
                .font(.title)
                .fontWeight(.bold)
            
            switch dailyData.state {
            case.successSeven(let dailyQuantities):
                Chart(dailyQuantities)  { set in
                    BarMark(
                        x: .value("Day", set.dailyQuantity.date_consommation),
                        y: .value("Quantity", set.dailyQuantity.quantite_ml)
                    )
                }
                .frame(width: 380,height: 300 )
            
            
            
            
            
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        
        
                
        }
        .task {
            await dailyData.getQuantitySevenDay(userId: utilisateur_id)
        }
    }
}

struct Statistique_Previews: PreviewProvider {
    static var previews: some View {
        Statistique()
            .environmentObject(DailyQuantityViewModel())
    }
}
