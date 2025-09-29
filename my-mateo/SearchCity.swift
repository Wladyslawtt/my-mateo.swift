//
//  SearchCity.swift
//  my-mateo
//
//  Created by Vladyslav Tarabunin on 29/09/2025.
//5

import SwiftUI
import SwiftData


// MARK: - Add City View
struct AddCityView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var vm = WeatherViewModel()
    
    @State private var name = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("City Name", text: $name)
                
                if isLoading {
                    ProgressView("Searching...")
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
            .navigationTitle("Add City")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        Task {
                            isLoading = true
                            if let (foundName, lat, lon) = await vm.fetchCoordinates(for: name) {
                                let newCity = City(name: foundName, latitude: lat, longitude: lon)
                                context.insert(newCity)
                                try? context.save()
                                dismiss()
                            } else {
                                errorMessage = "City not found"
                            }
                            isLoading = false
                        }
                    }
                    .disabled(name.isEmpty || isLoading)
                }
            }
        }
    }
}
