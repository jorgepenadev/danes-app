//
//  ExerciseRecordStore.swift
//  exercise-tracker
//
//  Created by Jorge Pena on 4/23/25.
//


import Foundation

class ExerciseRecordStore: ObservableObject {
    @Published var records: [String: [ExerciseRecord]] = [:]

    func addRecord(for exercise: String, value: Int) {
        let new = ExerciseRecord(date: Date(), value: value)
        records[exercise, default: []].append(new)
    }

    func deleteRecord(for exercise: String, record: ExerciseRecord) {
        records[exercise]?.removeAll { $0.id == record.id }
    }

    func getRecords(for exercise: String) -> [ExerciseRecord] {
        records[exercise] ?? []
    }
}
