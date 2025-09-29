//
//  my_mateoApp.swift
//  my-mateo
//
//  Created by Vladyslav Tarabunin on 29/09/2025.
//6

import SwiftUI
import SwiftData

@main
struct my_mateoApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: City.self)
    }
}
