import SwiftUI

struct RoomsListView: View {
    // Instantiate the ViewModel
    // @StateObject means: "I own this object, please keep it alive."
    @StateObject private var viewModel = RoomViewModel()
    
    let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
    
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
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.rooms) {room in
                                NavigationLink(destination: PlantsListView(roomName: room.name, roomID: room.id)) {
                                    RoomCardView(room: room)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
//
//                    List(viewModel.rooms) { room in
//                        NavigationLink(destination: PlantsListView(roomName: room.name, roomID: room.id)) {
//                            RoomRowView(room: room)
//                        }
//                    }
                }
            }
            .padding()
            .navigationTitle("My Home")
            .task {
                await viewModel.fetchRooms()
            }
        }
    }
}

struct RoomsListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomsListView()
    }
}
