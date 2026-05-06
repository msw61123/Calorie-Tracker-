//
//  FoodAPIService.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 5/1/26.
//

import Foundation

struct USDAFoodSearchResponse: Codable {
    let foods: [USDAFood]
}

struct USDAFood: Codable, Identifiable, Hashable {
    let fdcId: Int
    let description: String
    let foodNutrients: [USDAFoodNutrient]?

    var id: Int { fdcId }

    var calories: Int {
        guard let nutrients = foodNutrients else { return 0 }

        let energy = nutrients.first { nutrient in
            nutrient.nutrientNumber == "1008" ||
            nutrient.nutrientName?.lowercased().contains("energy") == true ||
            nutrient.nutrientName?.lowercased().contains("calorie") == true
        }

        return Int((energy?.value ?? 0).rounded())
    }
}

struct USDAFoodNutrient: Codable, Hashable {
    let nutrientId: Int?
    let nutrientName: String?
    let nutrientNumber: String?
    let unitName: String?
    let value: Double?
}

final class FoodAPIService {
    static let shared = FoodAPIService()

    private init() {}

    private let apiKey = "1DikhjS63oILuq0zVrSZuPZB1VbeXMvlH2CLwzGX"

    func searchFoods(query: String) async throws -> [USDAFood] {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return []
        }

        var components = URLComponents(string: "https://api.nal.usda.gov/fdc/v1/foods/search")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "pageSize", value: "25"),
            URLQueryItem(name: "dataType", value: "Foundation"),
            URLQueryItem(name: "dataType", value: "SR Legacy"),
            URLQueryItem(name: "sortby", value: "dataType.keyword")
        ]

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(USDAFoodSearchResponse.self, from: data)
        return decoded.foods
    }
}
