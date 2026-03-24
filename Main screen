import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            CalorieView()
        }
    }
}

// MARK: - Model
struct Meal: Identifiable {
    let id = UUID()
    let name: String
    let calories: Int
}

// MARK: - Main Screen
struct CalorieView: View {
    
    @State private var breakfast: [Meal] = [
        Meal(name: "Eggs", calories: 200)
    ]
    
    @State private var lunch: [Meal] = []
    @State private var dinner: [Meal] = []
    
    let goal = 2000
    
    var totalCalories: Int {
        (breakfast + lunch + dinner).reduce(0) { $0 + $1.calories }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                // 🔴 Calorie Ring
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    
                    Circle()
                        .trim(from: 0, to: min(Double(totalCalories) / Double(goal), 1))
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                    VStack {
                        Text("\(totalCalories)")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("of \(goal) cal")
                            .foregroundColor(.gray)
                    }
                }
                .frame(width: 180, height: 180)
                
                // Meal Sections
                MealSection(title: "Breakfast", meals: breakfast)
                MealSection(title: "Lunch", meals: lunch)
                MealSection(title: "Dinner", meals: dinner)
            }
            .padding()
        }
    }
}

// MARK: - Section UI
struct MealSection: View {
    
    var title: String
    var meals: [Meal]
    
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
                print("Add meal tapped for \(title)")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
