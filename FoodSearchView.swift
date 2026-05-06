//
//  FoodSearchView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 4/14/26.
//

import SwiftUI
struct FoodSearchView: View {
    @Binding var meals: [Meal]
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var results: [USDAFood] = []
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var selectedFood: USDAFood?
    @State private var showServingSheet = false
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                TextField("Search food...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                Button("Search") {
                    Task {
                        await searchFood()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            if isLoading {
                Spacer()
                ProgressView("Searching...")
                Spacer()
            } else if !errorMessage.isEmpty {
                Spacer()
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            } else if results.isEmpty {
                Spacer()
                Text("Search for a food item")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List(results) { food in
                    Button {
                        selectedFood = food
                        showServingSheet = true
                    } label: {
                        HStack {
                            Text(food.description)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(food.calories) cal")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Search Food")
        .sheet(isPresented: $showServingSheet) {
            if let selectedFood {
                ServingSizeView(food: selectedFood, meals: $meals) {
                    dismiss()
                }
            }
        }
    }
    func searchFood() async {
        errorMessage = ""
        isLoading = true
        do {
            results = try await FoodAPIService.shared
                .searchFoods(query: searchText)
                .filter { $0.calories > 0 }
                .filter { !$0.description.allSatisfy({ $0.isUppercase }) }
        } catch {
            results = []
            errorMessage = "Could not load food results. Check your API key or internet connection."
        }
        isLoading = false
    }
}

