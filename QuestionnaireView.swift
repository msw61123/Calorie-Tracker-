//
//  QuestionnaireView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 3/10/26.
//

import SwiftUI

struct QuestionnaireView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @AppStorage("didCompleteQuestionnaire") private var didCompleteQuestionnaire = false
    
    @State private var step = 0
    
    @AppStorage("savedAge") private var age = 25
    @AppStorage("savedHeightFeet") private var heightFeet = 5
    @AppStorage("savedHeightInches") private var heightInches = 8
    @AppStorage("savedWeight") private var weight = 150
    @AppStorage("savedGender") private var gender = "Female"
    @AppStorage("savedWorkoutDays") private var workoutDays = 3
    @AppStorage("savedGoal") private var goal = "Maintain Weight"
    
    let genders = ["Female", "Male", "Non-binary", "Prefer not to say"]
    let goals = ["Lose Weight", "Maintain Weight", "Gain Muscle"]
    
    var body: some View {
        VStack(spacing: 30) {
            
            if step == 0 {
                Text("How old are you?")
                    .font(.title)
                
                Picker("Age", selection: $age) {
                    ForEach(10...100, id: \.self) { num in
                        Text("\(num)")
                            .font(.system(size: 16))
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
            }
            
            if step == 1 {
                Text("What is your height?")
                    .font(.title)
                
                HStack(spacing: 0) {
                    Picker("Feet", selection: $heightFeet) {
                        ForEach(3...8, id: \.self) { num in
                            Text("\(num) ft")
                                .font(.system(size: 16))
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 140, height: 120)
                    .clipped()
                    
                    Picker("Inches", selection: $heightInches) {
                        ForEach(0...11, id: \.self) { num in
                            Text("\(num) in")
                                .font(.system(size: 16))
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 140, height: 120)
                    .clipped()
                }
            }
            
            if step == 2 {
                Text("What is your weight?")
                    .font(.title)
                
                Picker("Weight", selection: $weight) {
                    ForEach(50...600, id: \.self) { num in
                        Text("\(num) lbs")
                            .font(.system(size: 16))
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
            }
            
            if step == 3 {
                Text("What is your gender?")
                    .font(.title)
                
                Picker("Gender", selection: $gender) {
                    ForEach(genders, id: \.self) { item in
                        Text(item)
                            .font(.system(size: 16))
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
            }
            
            if step == 4 {
                Text("How many days per week do you exercise?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Picker("Workout Days", selection: $workoutDays) {
                    ForEach(0...7, id: \.self) { num in
                        Text("\(num) days")
                            .font(.system(size: 16))
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
            }
            
            if step == 5 {
                Text("What is your fitness goal?")
                    .font(.title)
                
                Picker("Goal", selection: $goal) {
                    ForEach(goals, id: \.self) { item in
                        Text(item)
                            .font(.system(size: 16))
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
            }
            
            HStack {
                Button("Back") {
                    if step > 0 {
                        step -= 1
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(step == 0 ? Color.gray : Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(step == 0)
                
                Button(step == 5 ? "Finish" : "Next") {
                    if step < 5 {
                        step += 1
                    } else {
                        didCompleteQuestionnaire = true
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
