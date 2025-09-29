//
//  Geocordinats.swift
//  my-mateo
//
//  Created by Vladyslav Tarabunin on 29/09/2025.
//3

import SwiftUI
import SwiftData

// MARK: - Geocoding API Response
struct GeocodingResponse: Codable {
    struct Result: Codable {
        let name: String
        let latitude: Double
        let longitude: Double
        let country: String?
    }
    let results: [Result]?
}
