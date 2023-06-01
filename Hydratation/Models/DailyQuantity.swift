//
//  Day.swift
//  Hydratation
//
//  Created by Arthur dubois on 30/05/2023.
//

import Foundation

struct DailyQuantity:Codable, Hashable {
    var quantite_ml: Int
    var date_consommation: Date
    var utilisateur_id: Int
    
    static var testData = [
        DailyQuantity(quantite_ml: 0, date_consommation: Date(), utilisateur_id: 1),
        DailyQuantity(quantite_ml: 0, date_consommation: Date(), utilisateur_id: 2),
        DailyQuantity(quantite_ml: 0, date_consommation: Date(), utilisateur_id: 3),
    ]
    
}

struct DailyQuantityResponse: Decodable {
    var results: [DailyQuantity]
}

struct DailyQuantityWrapper: Identifiable {
    let id = UUID()
    let dailyQuantity: DailyQuantity
}
