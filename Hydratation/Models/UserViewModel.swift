//
//  UserViewModel.swift
//  Hydratation
//
//  Created by Arthur dubois on 31/05/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    
    enum State {
        case notAvailable
        case loading
        case success(data: User)
        case failed(error: Error)
    }
    
    @Published var state: State = .notAvailable
    
    private let service: HydratationService = HydratationService()
    
    func getUser(from email: String) async -> User? {
        self.state = .loading
        do {
            
            let user = try await service.postUser(for: email)
            self.state = .success(data: user)
            print(user)
            return user
        } catch {
            self.state = .failed(error: error)
            print(error)
        }
        return nil
        
    }
}
