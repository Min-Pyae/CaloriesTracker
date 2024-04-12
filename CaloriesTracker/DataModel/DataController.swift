//
//  DataController.swift
//  CaloriesTracker
//
//  Created by Chris Min on 12/04/2024.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data: \(error.localizedDescription)")
            }
        }
    }
    
    // FUNCTION FOR SAVING DATA
    func saveFoodData(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Data could not be saved!")
        }
    }
    
    
    // FUNCTION FOR ADDING DATA
    func addFoodData(name: String, calories: Double, context: NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        // SAVE CHANGES TO THE CONTEXT
        saveFoodData(context: context)
    }
    
    
    // FUNCTION FOR UPDATING DATA
    func updateFoodData(food: Food, name: String, calories: Double, context: NSManagedObjectContext) {
        food.date = Date()
        food.name = name
        food.calories = calories
        
        // SAVE CHANGES TO THE CONTEXT
        saveFoodData(context: context)
    }
}
