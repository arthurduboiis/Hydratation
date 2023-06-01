//
//  User.swift
//  Hydratation
//
//  Created by Arthur dubois on 17/05/2023.
//

import Foundation

struct User: Codable, Hashable {
    var id: Int
    var adresse_mail: String
    
    static var testData = [
        User(id: 1, adresse_mail: "test1@gmail.com"),
        User(id: 2, adresse_mail: "test2@gmail.com"),
        User(id: 3, adresse_mail: "test3@gmail.com"),
    ]
}
