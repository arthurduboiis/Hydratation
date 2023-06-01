//
//  DayViewModel.swift
//  Hydratation
//
//  Created by Arthur dubois on 30/05/2023.
//

import Foundation

@MainActor
class DailyQuantityViewModel: ObservableObject {
    @Published var dailyQuantities: [DailyQuantity] = []
    
    enum State {
        case notAvailable
        case loading
        case success(data: DailyQuantity)
        case successSeven(data: [DailyQuantityWrapper])
        case failed(error: Error)
    }
    
    @Published var state: State = .notAvailable
    
    private let service: HydratationService = HydratationService()
    
    init(){
        getQuantities()
    }
    
    func getQuantities() {
        dailyQuantities.append(contentsOf: DailyQuantity.testData)
    }
    
    func addQuantity(userId: Int, quantity: Int) async {
        
        let currentDate = Date()
        
        do {
            try await service.sendQuantity(totalQuantity: quantity, date: currentDate, userId: userId)
            
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
    }
    
    
    func getQuantity(userId: Int) async -> Float{
//        if let quantity = dailyQuantities.first(where: { $0.userId == userId }) {
//                    return Float(quantity.totalQuantity)
//        }
        
        self.state = .loading
        
        do {
            let quantity = try await service.getQuantity(for: userId)
            self.state = .success(data: quantity)
            return Float(quantity.quantite_ml)
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
//
        return Float(0)
        
        
    }
    
    func getQuantitySevenDay(userId: Int) async -> [DailyQuantityWrapper]{
//        if let quantity = dailyQuantities.first(where: { $0.userId == userId }) {
//                    return Float(quantity.totalQuantity)
//        }
        
        self.state = .loading
        
        do {
            let quantities = try await service.getQuantitiesSevenDay(for: userId)
            let wrappedQuantities = quantities.map { DailyQuantityWrapper(dailyQuantity: $0) }
            self.state = .successSeven(data: wrappedQuantities)
            return wrappedQuantities
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
        return []
        
    }
    
   
    
   
}
