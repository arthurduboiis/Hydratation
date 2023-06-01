//
//  ProfileView.swift
//  Hydratation
//
//  Created by Arthur dubois on 17/05/2023.
//

import SwiftUI

struct ProfileView: View {
    
  
    
    @AppStorage("selectedGender") var selectedGender = ""
    private let genders = ["Male", "Female"]
    
    @AppStorage("height") private var height: String = ""
    @AppStorage("weight") private var weight: String = ""
    
    @AppStorage("userMail") private var utilisateur_mail = ""
    
    @AppStorage("selectedNotificationCount") private var selectedNotificationCount = 2
    
    @AppStorage("isAutoQuantityEnabled") private var isAutoQuantityEnabled = true
    @AppStorage("customQuantity") var customQuantity: Int = 0
    
    init() {
        
        if(selectedNotificationCount>0) {
            let content = UNMutableNotificationContent()
            content.title = "Don't forget to drink !"
            content.subtitle = "Take your Ricard and drink"
            content.sound = UNNotificationSound.default
            let timeInterval = Int(86400 / selectedNotificationCount)
            // show this notification five seconds from now
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }

    }

    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .padding(.top)
            
            
            Text(utilisateur_mail)
            
            
            VStack {
                HStack {
                    Text("Select gender")
                    Picker("", selection: $selectedGender) {

                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                HStack() {
                    Text("Enter your height (cm)")

                   TextField("Taille", text: $height)
                       .keyboardType(.numberPad)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       
                                
                }
                
                HStack {
                    Text("Enter your weight (kg)")

                    TextField("Poids", text: $weight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                       
                }
            }
            .padding()
          
            
            
            
            
            HStack {
                Text("Number of notification per day")
                            
                Picker("Nombre de notifications", selection: $selectedNotificationCount) {
                    Text("0").tag(0)
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                
            }
                .padding()
            
            VStack {
                HStack {
                    Text("Quantity Auto")
                    
                    Spacer()
                    
                    Toggle("", isOn: $isAutoQuantityEnabled)
                        .labelsHidden()
                        .onTapGesture {
                            if isAutoQuantityEnabled {
                                if let weightValue = Int(weight) {
                                    customQuantity = (weightValue - 20) * 15 + 1500
                                }
                            }
                        }
                }
                    
                
                if !isAutoQuantityEnabled {
                    
                    HStack {
                        Text("Custom quantity (cL)")
                        TextField("Custom quantity", value: $customQuantity, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                    }
                   
               }
                
            }
            .padding()
            
            
            
            
            
        }
        .onTapGesture {

              self.endTextEditing()
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}



