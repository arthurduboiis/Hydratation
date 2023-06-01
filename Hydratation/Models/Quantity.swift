//
//  Quantity.swift
//  Hydratation
//
//  Created by Arthur dubois on 30/05/2023.
//

import Foundation

struct Quantity: Identifiable {
    var id = UUID()
    var quantity: Int
    var isInFavorite: Bool
    
    static var testData = [
        Quantity(quantity: 2, isInFavorite: true),
        Quantity(quantity: 3, isInFavorite: false),
        Quantity(quantity: 25, isInFavorite: true)
    ]
}
