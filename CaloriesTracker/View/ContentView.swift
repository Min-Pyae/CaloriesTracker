//
//  ContentView.swift
//  CaloriesTracker
//
//  Created by Chris Min on 12/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // TO RETRIEVE DATA FROM DATABASE
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showAddFoodView = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .leading) {
                
                Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                
                List {
                    ForEach(food) { food in
                        NavigationLink(value: "H") {
                            HStack {
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    
                                    Text("\(Int(food.calories))") + Text(" calories")
                                        .foregroundStyle(.red)
                                }
                                
                                Spacer()
                                
                                Text(calculateTimeSince(date: food.date!))
                                    .foregroundStyle(.gray)
                                    .italic()
                                
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        withAnimation {
                            indexSet.map { food[$0] }.forEach(managedObjectContext.delete)
                            DataController().saveFoodData(context: managedObjectContext)
                        }
                    })
                    
                }
                .listStyle(.plain)
                
            }
            .navigationTitle("Calories Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddFoodView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddFoodView) {
                AddFoodView()
            }
            
        }

    }
    
    
    // FUNCTION FOR CALCULATING TOTAL CALORIES TODAY
    private func totalCaloriesToday() -> Double {
        
        var caloriesToday: Double = 0
        
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        
        return caloriesToday
        
    }
    
}

#Preview {
    ContentView()
}
