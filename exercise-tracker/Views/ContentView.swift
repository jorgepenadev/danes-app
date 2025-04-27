import SwiftUI

struct ContentView: View {
    @State private var menuItems: [MenuItem] = MenuData.sampleMenu
    @StateObject private var store = ExerciseRecordStore()

    var body: some View {
        Text("Dane's Body Shop")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(menuItems.indices, id: \.self) { index in
                        MenuRow(item: $menuItems[index], store: store)
                    }
                }
                .padding(5)
            }
        }
    }
}


#Preview {
    ContentView()
}
