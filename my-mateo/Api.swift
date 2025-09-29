//
//  Api.swift
//  my-mateo
//
//  Created by Vladyslav Tarabunin on 29/09/2025.
//2

import SwiftUI
import SwiftData


// MARK: - Weather API Response
struct WeatherResponse: Codable {
    struct CurrentWeather: Codable {
        let temperature: Double
    }
    let current_weather: CurrentWeather
}
