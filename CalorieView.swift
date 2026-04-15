//
//  CalorieView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 3/24/26.
//

import SwiftUI
struct Meal: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let calories: Int
    init(name: String, calories: Int) {
        self.id = UUID()
        self.name = name
        self.calories = calories
    }
}
struct CalorieView: View {
    @AppStorage("savedAge") private var age = 25
    @AppStorage("savedHeightFeet") private var heightFeet = 5
    @AppStorage("savedHeightInches") private var heightInches = 8
    @AppStorage("savedWeight") private var weight = 150
    @AppStorage("savedGender") private var gender = "Female"
    @AppStorage("savedWorkoutDays") private var workoutDays = 3
    @AppStorage("savedGoal") private var userGoal = "Maintain Weight"
    @State private var breakfast: [Meal] = []
    @State private var lunch: [Meal] = []
    @State private var dinner: [Meal] = []
    var calorieTarget: Int {
        CalorieCalculator.calorieGoal(
            age: age,
            feet: heightFeet,
            inches: heightInches,
            weightLbs: weight,
            gender: gender,
            workoutDays: workoutDays,
            goal: userGoal
        )
    }
    var totalCalories: Int {
        (breakfast + lunch + dinner).reduce(0) { $0 + $1.calories }
    }
    var todayKey: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return "meals_" + formatter.string(from: Date())
    }
    func saveMeals() {
        let allMeals = [
            "breakfast": breakfast,
            "lunch": lunch,
            "dinner": dinner
        ]
        if let encoded = try? JSONEncoder().encode(allMeals) {
            UserDefaults.standard.set(encoded, forKey: todayKey)
        }
    }
    func loadMeals() {
        if let data = UserDefaults.standard.data(forKey: todayKey),
           let decoded = try? JSONDecoder().decode([String: [Meal]].self, from: data) {
            breakfast = decoded["breakfast"] ?? []
            lunch = decoded["lunch"] ?? []
            dinner = decoded["dinner"] ?? []
        } else {
            breakfast = []
            lunch = []
            dinner = []
        }
    }
    var calorieRing: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
            Circle()
                .trim(from: 0, to: min(Double(totalCalories) / Double(max(calorieTarget, 1)), 1))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack {
                Text("\(totalCalories)")
                    .font(.largeTitle)
                    .bold()
                Text("of \(calorieTarget) cal")
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 180, height: 180)
    }
    var userInfo: some View {
        VStack(spacing: 4) {
            Text("Age: \(age)")
            Text("Height: \(heightFeet) ft \(heightInches) in")
            Text("Weight: \(weight) lbs")
            Text("Gender: \(gender)")
            Text("Workout Days: \(workoutDays)")
        }
        .font(.footnote)
        .foregroundColor(.gray)
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text(userGoal)
                    .font(.title2)
                    .bold()
                calorieRing
                userInfo
                MealSection(title: "Breakfast", meals: $breakfast)
                MealSection(title: "Lunch", meals: $lunch)
                MealSection(title: "Dinner", meals: $dinner)
            }
            .padding()
        }
        .navigationTitle("Calories")
        .onAppear {
            loadMeals()
        }
        .onChange(of: breakfast) {
            saveMeals()
        }
        .onChange(of: lunch) {
            saveMeals()
        }
        .onChange(of: dinner) {
            saveMeals()
        }
    }
}
struct MealSection: View {
    var title: String
    @Binding var meals: [Meal]
    @State private var showFoodSearch = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .bold()
            if meals.isEmpty {
                Text("No meals yet")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
                ForEach(meals) { meal in
                    HStack {
                        Text(meal.name)
                        Spacer()
                        Text("\(meal.calories) cal")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                }
            }
            Button("+ Add Meal") {
                showFoodSearch = true
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
            .sheet(isPresented: $showFoodSearch) {
                NavigationStack {
                    FoodSearchView(meals: $meals)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}


