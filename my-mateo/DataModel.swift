//
//  DataModel.swift
//  my-mateo
//
//  Created by Vladyslav Tarabunin on 29/09/2025.
//1

import SwiftUI
import SwiftData

// MARK: - SwiftData Model
@Model
class City {
    var name: String
    var latitude: Double
    var longitude: Double
    var temperature: Double?
    
    init(name: String, latitude: Double, longitude: Double, temperature: Double? = nil) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.temperature = temperature
    }
}
