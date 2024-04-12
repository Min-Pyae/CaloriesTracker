//
//  EditFoodView.swift
//  CaloriesTracker
//
//  Created by Chris Min on 12/04/2024.
//

import SwiftUI

struct EditFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    // REFERING TO EACH FOOD
    var food: FetchedResults<Food>.Element
    
    @StateObject private var dataController = DataController()
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        
        Form {
            
            Section {
                
                // FOOD NAME TEXT FIELD
                TextField("\(food.name!)", text: $name)
                    .onAppear {
                        name = food.name!
                        calories = food.calories
                    }
                
                
                // CALORIES SLIDER
                VStack {
                    
                    Text("Calories: \(Int(calories))")
                    
                    Slider(value: $calories, in: 0...1000, step: 10)
                    
                }
                
                
                // SAVE BUTTON
                HStack {
                    
                    Spacer()
                    
                    Button("Save") {
                        
                        dataController.updateFoodData(food: food, name: name, calories: calories, context: managedObjectContext)
                        
                        dismiss()
                        
                    }
                    
                    Spacer()
                }
                
            }
            .padding()
            
        }
        
    }
}


