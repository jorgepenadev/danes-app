//
//  ExerciseRecord.swift
//  exercise-tracker
//
//  Created by Jorge Pena on 4/23/25.
//


import Foundation

struct ExerciseRecord: Identifiable {
    let id = UUID()
    let date: Date
    let value: Int
}
