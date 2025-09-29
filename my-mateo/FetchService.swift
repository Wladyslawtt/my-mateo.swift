//
//  FetchService.swift
//  my-mateo
//
//  Created by Vladyslav Tarabunin on 29/09/2025.
//4

import SwiftUI
import SwiftData


// MARK: - ViewModel
@Observable
class WeatherViewModel {
    
    /// Fetch coordinates from city name
    func fetchCoordinates(for cityName: String) async -> (String, Double, Double)? {
        let encoded = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cityName
        let urlString = "https://geocoding-api.open-meteo.com/v1/search?name=\(encoded)&count=1"
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(GeocodingResponse.self, from: data)
            
            if let result = decoded.results?.first {
                return (result.name, result.latitude, result.longitude)
            }
        } catch {
            print("Geocoding error:", error)
        }
        return nil
    }
    
    /// Fetch weather from coordinates
    func fetchWeather(for city: City, context: ModelContext) async {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&current_weather=true"
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
            
            city.temperature = decoded.current_weather.temperature
            try context.save()
        } catch {
            print("Weather fetch error:", error)
        }
    }
}
