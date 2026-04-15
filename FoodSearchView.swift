//
//  FoodSearchView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 4/14/26.
//

import SwiftUI
struct FoodItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let calories: Int
}
struct FoodSearchView: View {
    @Binding var meals: [Meal]
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    let foodDatabase: [FoodItem] = [
        FoodItem(name: "Apple", calories: 95),
        FoodItem(name: "Banana", calories: 105),
        FoodItem(name: "Egg", calories: 78),
        FoodItem(name: "Chicken Breast (100g)", calories: 165),
        FoodItem(name: "White Rice (1 cup)", calories: 205),
        FoodItem(name: "Brown Rice (1 cup)", calories: 216),
        FoodItem(name: "Salmon (100g)", calories: 208),
        FoodItem(name: "Ground Beef (100g)", calories: 250),
        FoodItem(name: "Broccoli (1 cup)", calories: 55),
        FoodItem(name: "Avocado", calories: 240),
        FoodItem(name: "Oatmeal (1 cup)", calories: 154),
        FoodItem(name: "Greek Yogurt", calories: 100),
        FoodItem(name: "Milk (1 cup)", calories: 103),
        FoodItem(name: "Bread Slice", calories: 80),
        FoodItem(name: "Peanut Butter (2 tbsp)", calories: 190),
        FoodItem(name: "Cheddar Cheese (1 oz)", calories: 113),
        FoodItem(name: "Turkey Sandwich", calories: 320),
        FoodItem(name: "Protein Shake", calories: 160),
        FoodItem(name: "Pasta (1 cup)", calories: 220),
        FoodItem(name: "Pizza Slice", calories: 285),
        FoodItem(name: "French Fries (medium)", calories: 365),
        FoodItem(name: "Hamburger", calories: 354),
        FoodItem(name: "Orange", calories: 62),
        FoodItem(name: "Strawberries (1 cup)", calories: 49),
        FoodItem(name: "Almonds (1 oz)", calories: 164)
    ]
    var filteredFoods: [FoodItem] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return foodDatabase
        } else {
            return foodDatabase.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    var body: some View {
        VStack {
            TextField("Search food...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding()
            if filteredFoods.isEmpty {
                Spacer()
                Text("No foods found")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List(filteredFoods) { item in
                    Button {
                        meals.append(Meal(name: item.name, calories: item.calories))
                        dismiss()
                    } label: {
                        HStack {
                            Text(item.name)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(item.calories) cal")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Search Food")
        
        
        
    }
}
