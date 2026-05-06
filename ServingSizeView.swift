//
//  ServingSizeView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 5/5/26.
//

import SwiftUI
struct ServingSizeView: View {
    
    let food: USDAFood
    @Binding var meals: [Meal]
    var onDone: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var quantity = 1
    @State private var servingType = "Serving"
    
    let servingTypes = ["Serving", "Half Serving", "Double Serving", "Grams"]
    @State private var grams = 100
    
    var finalCalories: Int {
        switch servingType {
        case "Half Serving":
            return Int(Double(food.calories) * 0.5)
        case "Double Serving":
            return food.calories * 2
        case "Grams":
            return Int(Double(food.calories) * (Double(grams) / 100.0))
        default:
            return food.calories * quantity
        }
    }
    
    var servingText: String {
        switch servingType {
        case "Half Serving":
            return "1/2 serving"
        case "Double Serving":
            return "2 servings"
        case "Grams":
            return "\(grams) g"
        default:
            return "\(quantity) serving(s)"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                Text(food.description)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("Base: \(food.calories) cal")
                    .foregroundColor(.gray)
                
                Picker("Serving Type", selection: $servingType) {
                    ForEach(servingTypes, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                if servingType == "Serving" {
                    Picker("Quantity", selection: $quantity) {
                        ForEach(1...10, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120)
                }
                
                if servingType == "Grams" {
                    Picker("Grams", selection: $grams) {
                        ForEach(Array(stride(from: 10, through: 600, by: 10)), id: \.self) { gram in
                            Text("\(gram) g")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120)
                }
                
                Text("Total: \(finalCalories) cal")
                    .font(.title2)
                    .bold()
                
                Button("Add Food") {
                    meals.append(
                        Meal(
                            name: food.description,
                            calories: finalCalories,
                            servingText: servingText
                        )
                    )
                    dismiss()
                    onDone()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
            .navigationTitle("Serving Size")
        }
    }
}
