import SwiftUI

// MARK: - Main ContentView

struct ContentView: View {
    @State private var menuItems: [MenuItem] = [
        MenuItem(title: "Snatch", icon: "bolt.fill", color: .orange, weight: 185),
        MenuItem(title: "Clean and Jerk", icon: "flame.fill", color: .red, weight: 245),
        MenuItem(title: "Front Squat", icon: "arrow.down.circle.fill", color: .blue, weight: 275),
        MenuItem(title: "Back Squat", icon: "arrow.up.circle.fill", color: .green, weight: 325),
        MenuItem(title: "Overhead Press", icon: "person.fill", color: .purple, weight: 135)
    ]

    @StateObject private var store = ExerciseRecordStore()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(menuItems.indices, id: \.self) { index in
                        MenuRow(item: $menuItems[index], store: store)
                    }
                }
                .padding()
            }
            .navigationTitle("Dane's Body Shop")
        }
    }
}

// MARK: - Menu Row

struct MenuRow: View {
    @Binding var item: MenuItem
    @ObservedObject var store: ExerciseRecordStore
    @State private var showPopup = false

    var body: some View {
        HStack(spacing: 12) {
            NavigationLink(destination: ExerciseDetailScreen(title: item.title, store: store)) {
                HStack {
                    Image(systemName: item.icon)
                        .foregroundColor(item.color)
                        .frame(width: 30)

                    Text(item.title)
                        .foregroundColor(.primary)
                }
            }

            Spacer()

            Button(action: {
                showPopup = true
            }) {
                Text("\(item.weight) lbs")
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showPopup) {
                EditWeightSheet(item: $item)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        )
    }
}

// MARK: - Edit Weight Sheet

struct EditWeightSheet: View {
    @Binding var item: MenuItem
    @State private var inputWeight: String = ""
    @State private var selectedPercent: Double = 0.85

    var body: some View {
        VStack(spacing: 24) {
            Text("Edit \(item.title) Weight")
                .font(.title2)
                .fontWeight(.bold)

            TextField("Enter weight", text: $inputWeight)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            VStack {
                Text("Quick Percentages")
                    .font(.headline)
                HStack(spacing: 12) {
                    ForEach([0.6, 0.7, 0.8, 0.85, 0.9], id: \.self) { percent in
                        Button("\(Int(percent * 100))%") {
                            selectedPercent = percent
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(selectedPercent == percent ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                        .clipShape(Capsule())
                    }
                }

                if let baseWeight = Double(inputWeight) {
                    Text("= \(Int(baseWeight * selectedPercent)) lbs")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.top, 6)
                }
            }

            Button("Save") {
                if let newWeight = Double(inputWeight) {
                    item.weight = Int(newWeight)
                }
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .onAppear {
            inputWeight = "\(item.weight)"
        }
        .presentationDetents([.medium, .large])
    }
}

// MARK: - Detail Screen

struct ExerciseDetailScreen: View {
    let title: String
    @ObservedObject var store: ExerciseRecordStore
    @State private var input = ""

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                TextField("New weight", text: $input)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)

                Button("Add") {
                    if let val = Int(input) {
                        store.addRecord(for: title, value: val)
                        input = ""
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()

            List {
                ForEach(store.getRecords(for: title)) { record in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(record.value) lbs")
                                .fontWeight(.bold)
                            Text(record.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(role: .destructive) {
                            store.deleteRecord(for: title, record: record)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
        .navigationTitle(title)
    }
}

// MARK: - Models

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    var weight: Int
}

struct ExerciseRecord: Identifiable {
    let id = UUID()
    let date: Date
    let value: Int
}

// MARK: - Record Store

class ExerciseRecordStore: ObservableObject {
    @Published var records: [String: [ExerciseRecord]] = [:] // Keyed by exercise title

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

// MARK: - Preview

#Preview {
    ContentView()
}
