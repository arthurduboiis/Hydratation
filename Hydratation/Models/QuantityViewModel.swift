//
//  QuantityViewModel.swift
//  Hydratation
//
//  Created by Arthur dubois on 30/05/2023.
//

import Foundation

class QuantityViewModel: ObservableObject {
    @Published var quantities: [Quantity] = []
    
    init(){
        getQuantities()
    }
    
    func getQuantities() {
        quantities.append(contentsOf: Quantity.testData)
    }
    
    func addItem(quantity: Int, isInFavorite: Bool) {
        let newQuantity = Quantity(quantity: quantity, isInFavorite: isInFavorite)
        quantities.append(newQuantity)
    }
    
    func deleteItem(indexSet: IndexSet){
        quantities.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        quantities.move(fromOffsets: from, toOffset: to)
    }
    
    func updateItem(quantity: Quantity){
        let index = quantities.firstIndex { existingQuantity in
            return quantity.id == existingQuantity.id
        }
        
        if let index = index {
            quantities[index].isInFavorite.toggle()
        }
    }
}
