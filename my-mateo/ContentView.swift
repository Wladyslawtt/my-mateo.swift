//
//  ContentView.swift
//  my-mateo
//
//  Created by Vladyslav Tarabunin on 29/09/2025.
//

import SwiftUI
import SwiftData


// MARK: - Main View
struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var cities: [City]
    @State private var vm = WeatherViewModel()
    @State private var showingAddCity = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cities) { city in
                    HStack {
                        Text(city.name)
                        Spacer()
                        if let temp = city.temperature {
                            Text("\(temp, specifier: "%.1f")°C")
                                .foregroundStyle(.blue)
                        } else {
                            Text("Loading...")
                                .foregroundStyle(.gray)
                        }
                    }
                    .task {
                        await vm.fetchWeather(for: city, context: context)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(cities[index])
                    }
                }
            }
            .navigationTitle("Weather App")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingAddCity = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddCity) {
                AddCityView()
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
