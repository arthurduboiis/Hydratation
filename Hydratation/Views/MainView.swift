//
//  ContentView.swift
//  Hydratation
//
//  Created by Arthur dubois on 17/05/2023.
//

import SwiftUI

struct MainView: View {
    @AppStorage("currentView") var currentView = 1
    
    @State private var selectedTab = "home"
    
    init(currentView: Int = 1) {
        self.currentView = currentView
    }
    
    var body: some View {
        
        
        
        if currentView == 1 {
            OnBoardingView(title: "Welcome to our app", description: "Hopefully you will drink a lot with us ", bgColor: "yellow", img: "ricard", question: false)
        }
        
        if currentView == 2 {
            OnBoardingView(title: "Get Started", description: "You can start using our application", bgColor: "yellow", img: "water", question: true)
        }
        
        if currentView == 3 {
            OnBoardingView(title: "Get Started", description: "You can start using our application", bgColor: "yellow", img: "ricard", question: false)
        }
        
        if currentView == 4 {
            TabView(selection: $selectedTab){
                Statistique()
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                        Text("Statistiques")
                    }
                    .tag("stat")
                
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag("home")
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    .tag("profile")
            }
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
