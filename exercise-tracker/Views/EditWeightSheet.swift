import SwiftUI

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
