import SwiftUI

struct ContentView: View {
    @State private var menuItems: [MenuItem] = MenuData.sampleMenu
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


#Preview {
    ContentView()
}
