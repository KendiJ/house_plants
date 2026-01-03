import SwiftUI

struct RoomsListView: View {
    // Instantiate the ViewModel
    // @StateObject means: "I own this object, please keep it alive."
    @StateObject private var viewModel = RoomViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Watering...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                        Text(error)
                        Button("Retry") {
                            Task {await viewModel.fetchRooms()}
                        }
                    }
                } else {
                    List(viewModel.rooms) { room in
                        NavigationLink(destination: Text("Plant list for: \(room.name)")) {
                            RoomRowView(room: room)
                        }
                    }
                }
            }
            .navigationTitle("My Home")
            .task {
                await viewModel.fetchRooms()
            }
        }
    }
}

#Preview {
    RoomsListView()
}
