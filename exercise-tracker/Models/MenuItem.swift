//
//  MenuItem.swift
//  exercise-tracker
//
//  Created by Jorge Pena on 4/23/25.
//


import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    var weight: Int
}
