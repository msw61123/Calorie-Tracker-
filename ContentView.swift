import SwiftUI

struct Meal: Identifiable {
    let id = UUID()
    let name: String
    let calories: Int
}

struct FoodSearchView: View {
    
    @Binding var meals: [Meal]
    
    @State private var searchText = ""
    @State private var results: [String] = []
    
    var body: some View {
        VStack {
            
            // 🔍 Search bar
            TextField("Search food...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            // 🔘 Search button (avoids onChange issues)
            Button("Search") {
                searchFood()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            // 📋 Results (fake placeholders)
            if results.isEmpty {
                Spacer()
                Text("No results yet")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List(results, id: \.self) { item in
                    Button {
                        // placeholder calorie value for now
                        meals.append(Meal(name: item, calories: 100))
                    } label: {
                        Text(item)
                    }
                }
            }
        }
        .navigationTitle("Search Food")
    }
    
    // 🔌 Placeholder search function (NO DATABASE)
    func searchFood() {
        let query = searchText.lowercased()
        
        // fake matching system (no API, no DB)
        if query.isEmpty {
            results = []
        } else {
            results = [
                "Chicken Breast",
                "Rice",
                "Eggs",
                "Apple",
                "Banana"
            ].filter { $0.lowercased().contains(query) }
        }
    }
}
