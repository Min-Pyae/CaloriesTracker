//
//  AddFoodView.swift
//  CaloriesTracker
//
//  Created by Chris Min on 12/04/2024.
//

import SwiftUI

struct AddFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        
        Form {
            
            Section {
                
                TextField("Food name", text: $name)
                
                VStack {
                    
                    Text("Calories: \(Int(calories))")
                    
                    Slider(value: $calories, in: 0...1000, step: 10)
                    
                }
                
                HStack {
                    
                    Spacer()
                    
                    Button("Save") {
                        
                        DataController().addFoodData(name: name, calories: calories, context: managedObjectContext)
                        
                        dismiss()
                        
                    }
                    
                    Spacer()
                }
                
            }
            .padding()
            
        }
        
    }
}

#Preview {
    AddFoodView()
}
