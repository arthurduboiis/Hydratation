//
//  FavoritesView.swift
//  Hydratation
//
//  Created by Arthur dubois on 17/05/2023.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var data: QuantityViewModel
    @EnvironmentObject var dailyData: DailyQuantityViewModel
    @State private var showAddTextField = false
    @State private var newWaterQuantity = 0
    @AppStorage("userId") private var utilisateur_id = 0
    
    @Binding var presentMe : Bool
    
    var body: some View {
        NavigationView {
            
            VStack{
                List {
                    ForEach(data.quantities) { quantity in
                        CardView(quantity: quantity)
                            .onTapGesture {
                                Task {
                                    await dailyData.addQuantity(userId: utilisateur_id, quantity: quantity.quantity)
                                }
                                presentMe.toggle()
                            }
                           
                    }
                    .onDelete(perform: data.deleteItem)
                    .onMove(perform: data.moveItem)
                    
                    
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Favorites")
                
                
                if showAddTextField {
                    TextField("New quantity", value: $newWaterQuantity,formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                    Button(action: {
                        data.addItem(quantity: newWaterQuantity, isInFavorite: false)
                        showAddTextField.toggle()
                    }, label: {
                        Text("Confirm")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    
                }
                Button(action: {
                    showAddTextField.toggle()
                }, label: {
                    Text("Add a quantity")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .padding()
                
            }
            
            
        }
            
    }
        
   
}


