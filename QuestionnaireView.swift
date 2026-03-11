//
//  QuestionnaireView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 3/10/26.
//

import SwiftUI

struct QuestionnaireView: View
{
    @EnvironmentObject var authVM: AuthViewModel
    @AppStorage("didCompleteQuestionnaire") private var didCompleteQuestionnaire = false
    
    @State private var step = 0
    
    @State private var age = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var goal = "Maintain Weight"
    
    let goals = ["Lose Weight", "Maintain Weight", "Gain Muscle"]
    
    var body: some View {
        VStack(spacing: 30) {
            
            if step == 0 {
                Text("How old are you?")
                    .font(.title)
                
                TextField("Age", text: $age)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
            }
            
            if step == 1 {
                Text("What is your height?")
                    .font(.title)
                
                TextField("Height (ft/in)", text: $height)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
            }
            
            if step == 2 {
                Text("What is your weight?")
                    .font(.title)
                
                TextField("Weight (lbs)", text: $weight)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
            }
            
            if step == 3 {
                Text("What is your fitness goal?")
                    .font(.title)
                
                Picker("Goal", selection: $goal) {
                    ForEach(goals, id: \.self) { g in
                        Text(g)
                    }
                }
                .pickerStyle(.wheel)
                .padding()
            }
            
            Button(step == 3 ? "Finish" : "Next") {
                if step < 3 {
                    step += 1
                } else {
                    print("Age:", age)
                    print("Height:", height)
                    print("Weight:", weight)
                    print("Goal:", goal)
                    
                    didCompleteQuestionnaire = true
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .padding()
    }
}
