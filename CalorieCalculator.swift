//
//  CalorieCalculator.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 3/24/26.
//

import Foundation

struct CalorieCalculator {
    
    static func feetInchesToCm(feet: Int, inches: Int) -> Double {
        let totalInches = (feet * 12) + inches
        return Double(totalInches) * 2.54
    }
    
    static func lbsToKg(_ pounds: Int) -> Double {
        Double(pounds) * 0.453592
    }
    
    static func activityMultiplier(workoutDays: Int) -> Double {
        switch workoutDays {
        case 0...1:
            return 1.2
        case 2...3:
            return 1.375
        case 4...5:
            return 1.55
        case 6:
            return 1.725
        case 7:
            return 1.9
        default:
            return 1.2
        }
    }
    
    static func calculateBMR(age: Int, feet: Int, inches: Int, weightLbs: Int, gender: String) -> Double {
        let weightKg = lbsToKg(weightLbs)
        let heightCm = feetInchesToCm(feet: feet, inches: inches)
        
        if gender == "Male" {
            return (10 * weightKg) + (6.25 * heightCm) - (5 * Double(age)) + 5
        } else {
            return (10 * weightKg) + (6.25 * heightCm) - (5 * Double(age)) - 161
        }
    }
    
    static func calculateTDEE(age: Int, feet: Int, inches: Int, weightLbs: Int, gender: String, workoutDays: Int) -> Double {
        let bmr = calculateBMR(age: age, feet: feet, inches: inches, weightLbs: weightLbs, gender: gender)
        return bmr * activityMultiplier(workoutDays: workoutDays)
    }
    
    static func calorieGoal(age: Int, feet: Int, inches: Int, weightLbs: Int, gender: String, workoutDays: Int, goal: String) -> Int {
        let tdee = calculateTDEE(
            age: age,
            feet: feet,
            inches: inches,
            weightLbs: weightLbs,
            gender: gender,
            workoutDays: workoutDays
        )
        
        switch goal {
        case "Lose Weight":
            return Int(tdee - 500)
        case "Gain Muscle":
            return Int(tdee + 250)
        default:
            return Int(tdee)
        }
    }
}
