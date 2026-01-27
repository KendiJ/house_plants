import SwiftUI

struct PlantsListView: View {
    let roomName: String
    let roomID: Int
    
    // We reuse the PlantService directly here for simplicity
    @State private var plants: [Plant] = []
    @State private var isLoading = true
    @State private var errorMessage: String? = nil
    @State private var isShowingAddSheet =  false
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView("Checking for plants...")
            } else if let error = errorMessage {
                VStack {
                    Image(systemName: "exclamationMark.triangle")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                    Text(error)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            } else if plants.isEmpty {
                ContentUnavailableView(
                    "No plants here",
                    systemImage: "leaf",
                    description: Text("This room is looking a little empty")
                )
            } else {
                List(plants) { plant in
                    NavigationLink(destination: PlantDetailView(plant: plant, roomName: roomName)){
                        PlantRowView(plant: plant)
                    }
                }
            }
        }
        .navigationTitle(roomName)
        .toolbar {
            Button {
                isShowingAddSheet = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isShowingAddSheet) {
            AddPlantView(roomID: roomID)
                // When the sheet closes, refresh the list!
                .onDisappear {
                    Task { await loadPlants() }
                }
        }
        .task {
            await loadPlants()
        }
        
    }
    
    func loadPlants() async {
        do {
            self.plants = try await PlantService.shared.fetchPlants(forRoomID: roomID)
            self.isLoading = false
        } catch {
            self.errorMessage = "Could not load plants: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
}

