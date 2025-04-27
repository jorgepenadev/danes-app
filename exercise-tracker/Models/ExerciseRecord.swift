//
//  ExerciseRecord.swift
//  exercise-tracker
//
//  Created by Jorge Pena on 4/23/25.
//


import Foundation
import SwiftUI

struct ExerciseRecord: Identifiable, Codable {
    let id:  UUID
    let date: Date
    let value: Int
}
