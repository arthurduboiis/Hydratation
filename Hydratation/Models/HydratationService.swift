//
//  HydratationService.swift
//  Hydratation
//
//  Created by Arthur dubois on 31/05/2023.
//

import Foundation


struct HydratationService {
    
    enum HydraError: Error {
        case Failed
        case failedToDecode
        case invalideStatusCode
        case invalideUserName
    }
    
    func getQuantitiesSevenDay(for userId: Int) async throws -> [DailyQuantity] {
        let baseURL = "https://ricard.notavone.fr/api/"
        let endPoint = baseURL + "consommations/last-seven-days/\(userId)"
        
        guard let url = URL(string: endPoint) else {
            throw HydraError.invalideUserName
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw HydraError.invalideStatusCode
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let decodedData = try decoder.decode([DailyQuantity].self, from: data)
        print(decodedData)
        return decodedData
    }
    
    func getQuantity(for userId: Int) async throws -> DailyQuantity {
        let baseURL = "https://ricard.notavone.fr/api/"
        let endPoint = baseURL + "consommations/this-day/\(userId)"
        
        guard let url = URL(string: endPoint) else {
            throw HydraError.Failed
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw HydraError.invalideStatusCode
        }
        print(data)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let decodedData = try decoder.decode(DailyQuantity.self, from: data)
        print(decodedData)
        return decodedData
    }
    
    func sendQuantity(totalQuantity: Int, date: Date, userId: Int) async throws {
        let baseURL = "https://ricard.notavone.fr/api/"
        let endPoint = baseURL + "consommations/"
        
        guard let url = URL(string: endPoint) else {
            throw HydraError.Failed
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let dateFormatter = ISO8601DateFormatter()
        let dateString = dateFormatter.string(from: date)
        
        let parameters: [String: Any] = [
            "quantite_ml": totalQuantity,
            "date_consommation": dateString,
            "utilisateur_id": userId
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
            print(response)
            throw HydraError.invalideStatusCode
        }
    }
    
    func postUser(for email: String) async throws -> User {
        let baseURL = "https://ricard.notavone.fr/api/"
        let endPoint = baseURL + "utilisateurs/"
        
        guard let url = URL(string: endPoint) else {
            throw HydraError.Failed
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        
        let parameters: [String: Any] = [
            "adresse_mail": email
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
            print(response)
            throw HydraError.invalideStatusCode
            
        }
        
        print(httpResponse.statusCode)
        
        let decodedData = try JSONDecoder().decode(User.self, from: data)
        
        return decodedData
    }
}
