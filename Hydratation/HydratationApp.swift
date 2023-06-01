//
//  HydratationApp.swift
//  Hydratation
//
//  Created by Arthur dubois on 17/05/2023.
//

import SwiftUI

@main
struct HydratationApp: App {
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if let error = error {
                print(error)
            }
            
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(QuantityViewModel())
                .environmentObject(DailyQuantityViewModel())
                .environmentObject(UserViewModel())
        }
    }
}
