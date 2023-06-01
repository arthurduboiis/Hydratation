//
//  CardView.swift
//  Hydratation
//
//  Created by Arthur dubois on 17/05/2023.
//

import SwiftUI

struct CardView: View {
    let quantity: Quantity
    
    @EnvironmentObject var data: QuantityViewModel
    
    var body: some View {
        HStack {
            Text(" Quantité d'eau : \(quantity.quantity) mL")
            Spacer()
            
            Image(systemName: quantity.isInFavorite ? "star.fill" : "star")
                .foregroundColor(quantity.isInFavorite ? .yellow : .black)
                .onTapGesture {
                    data.updateItem(quantity: quantity)
                }
          
        }
        .font(.title2)
        .padding(.vertical, 10)
    }
}
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(quantity: Quantity.testData[0])
            .previewLayout(.sizeThatFits)
            .environmentObject(QuantityViewModel())
        
        CardView(quantity: Quantity.testData[1])
            .previewLayout(.sizeThatFits)
            .environmentObject(QuantityViewModel())
    }
}
