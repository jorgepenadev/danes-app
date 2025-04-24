import SwiftUI

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

            Button(action: { showPopup = true }) {
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
