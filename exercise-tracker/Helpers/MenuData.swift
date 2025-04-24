//
//  MenuData.swift
//  exercise-tracker
//
//  Created by Jorge Pena on 4/23/25.
//


import SwiftUI

enum MenuData {
    static let sampleMenu: [MenuItem] = [
        MenuItem(title: "Snatch", icon: "bolt.fill", color: .orange, weight: 185),
        MenuItem(title: "Clean and Jerk", icon: "flame.fill", color: .red, weight: 245),
        MenuItem(title: "Front Squat", icon: "arrow.down.circle.fill", color: .blue, weight: 275),
        MenuItem(title: "Back Squat", icon: "arrow.up.circle.fill", color: .green, weight: 325),
        MenuItem(title: "Overhead Press", icon: "person.fill", color: .purple, weight: 135)
    ]
}
