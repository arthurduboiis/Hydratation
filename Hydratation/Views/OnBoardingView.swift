//
//  OnBoardingView.swift
//  Hydratation
//
//  Created by Arthur dubois on 31/05/2023.
//

import SwiftUI

var totalViews = 3

struct OnBoardingView: View {
    
    @AppStorage("currentView") var currentView = 1
    
    var title: String
    var description: String
    var bgColor: String
    var img: String
    var question: Bool
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @AppStorage("selectedGender") var selectedGender = ""
    let genders = ["Male", "Female"]
    
    @AppStorage("height") private var height: String = ""
    @AppStorage("weight") private var weight: String = ""
    
    @AppStorage("isAutoQuantityEnabled") private var isAutoQuantityEnabled = false
    @AppStorage("customQuantity") private var customQuantity = 0
    @AppStorage("userId") private var utilisateur_id = 0
    @AppStorage("userMail") private var utilisateur_mail = ""
    @State private var showAlert = false

    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Text("Hydratation !")
                        .foregroundColor(Color.black)
                        .accessibilityLabel("Hydratation !")
                        .fontWeight(.bold)
                    Spacer()
                }.padding()
                Spacer()
                VStack(alignment: .center){
                    if question == false {
                        Image(img)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    
                        Text(title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                            .font(.title)
                            .padding(.top)
                        
                        
                        Text(description)
                            .padding(.top, 5.0)
                            .foregroundColor(Color.black)
                        Spacer(minLength: 0)
                    }
                    else  {
                        VStack {
                            
                            TextField("Enter your mail", text: $utilisateur_mail)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .onSubmit {
                                    Task {
                                        let user = await userViewModel.getUser(from: utilisateur_mail)
                                        utilisateur_id = user?.id ?? 0
                                        utilisateur_mail = user?.adresse_mail ?? ""
                                    }
                                }
                            
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
                        .onTapGesture {

                              self.endTextEditing()
                        } 
                        .padding()
                        
                        
                        VStack {
                            HStack {
                                Text("Quantity Auto")
                                
                                Spacer()
                                
                                Toggle("", isOn: $isAutoQuantityEnabled)
                                    .labelsHidden()
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
                        
                        Spacer()
                    }
                    
                }
                .padding()
                .overlay(
                    HStack{
                        
                        if currentView == 1 {
                            ContainerRelativeShape()
                                .foregroundColor(.black)
                                .frame(width: 25, height: 5)
                        } else {
                            ContainerRelativeShape()
                                .foregroundColor(.black.opacity(0.5))
                                .frame(width: 25, height: 5)
                        }
                        
                        if currentView == 2 {
                            ContainerRelativeShape()
                                .foregroundColor(.black)
                                .frame(width: 25, height: 5)
                        } else {
                            ContainerRelativeShape()
                                .foregroundColor(.black.opacity(0.5))
                                .frame(width: 25, height: 5)
                        }
                        
                        if currentView == 3 {
                            ContainerRelativeShape()
                                .foregroundColor(.black)
                                .frame(width: 25, height: 5)
                        } else {
                            ContainerRelativeShape()
                                .foregroundColor(.black.opacity(0.5))
                                .frame(width: 25, height: 5)
                        }
                        
                        Spacer()
                        Button(
                            action:{
                                withAnimation(.easeOut) {
                                    
                                    if currentView == 1 || currentView == 3{
                                        currentView += 1
                                    } else if currentView == 3 {
                                        currentView = 1
                                    } else if currentView == 2 {
                                        if utilisateur_mail.isEmpty {
                                            showAlert = true
                                        }
                                        else {
                                            currentView += 1
                                            Task {
                                                let user = await userViewModel.getUser(from: utilisateur_mail)
                                                utilisateur_id = user?.id ?? 0
                                                utilisateur_mail = user?.adresse_mail ?? ""
                                            }
                                            
                                        }
                                    }
                                }
                            },
                            label: {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 35.0, weight: .semibold))
                                    .frame(width: 55, height: 55)
                                    .background(Color("BgNextBtn"))
                                    .clipShape(Circle())
                                    .padding(17)
                                    .overlay(
                                        ZStack{
                                            Circle()
                                                .stroke(Color.black.opacity(0.4), lineWidth: 2)
                                                .padding()
                                                .foregroundColor(Color.black)
                                        }
                                    )
                            }
                        )
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Empty Email"),
                                message: Text("Please enter your email"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                        .padding()
                    ,alignment: .bottomTrailing
                )
            }
        }
        .background(
                       LinearGradient(colors: [
                           Color(bgColor),Color("BgNextBtn")]
                                      ,startPoint: .top, endPoint: .bottom)
                   )
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(title: "Welcome to our app", description: "you will drink to a better live", bgColor: "yellow", img: "water", question: true)
    }
}

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}

