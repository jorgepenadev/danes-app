import SwiftUI

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
