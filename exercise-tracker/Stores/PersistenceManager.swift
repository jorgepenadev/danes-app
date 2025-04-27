import Foundation

func saveRecord<T: Encodable>(exerciseType: String, _ record: T) async {
    let fileManager = FileManager.default
    guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return
    }
    
    let fileURL = directory.appendingPathComponent(exerciseType + "LogRecord.json")
    print("Saving record to:", fileURL)
    
    do {
        let data = try JSONEncoder().encode(record)
        try data.write(to: fileURL)
        print("✅ Saved record to:", fileURL)
    } catch {
        print("❌ Error saving record:", error)
    }
}
