import SwiftUI

struct PlantsListView: View {
    let room: Room
    
    // We reuse the PlantService directly here for simplicity
    @State private var plants: [Plant] = []
    @State private var isLoading = true
    @State private var errorMessage: String? = nil
    @State private var isShowingAddSheet =  false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack(alignment: .bottomLeading) {
                    if let urlString = room.image_url, let url = URL(string: urlString) {
                        AsyncImage(url: url) {image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipped()
                        } placeholder: {
                            Color.gray.opacity(0.2).frame(height: 250)
                        }
                    } else {
                        Color.green.opacity(0.2).frame(height: 250)
                    }
                    LinearGradient(colors: [.black.opacity(0.6), .clear], startPoint: .bottom, endPoint: .top)
                    
                    VStack(alignment: .leading) {
                        Text(room.name)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(.white)
                        Text("\(plants.count) Plants")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .padding()
                }
                VStack(spacing: 16) {
                    if isLoading {
                        ProgressView("Loading plants...")
                            .padding(.top, 50)
                    } else if plants.isEmpty {
                        ContentUnavailableView(
                            "Not plants yet",
                            systemImage: "leaf",
                            description: Text("Tap + button to add a one!")
                        )
                        .padding(.top, 50)
                    }else {
                        ForEach(plants) { plant in
                            NavigationLink(destination: PlantDetailView(plant: plant, roomName: room.name)) {
                                PlantCardView(plant: plant)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar {
            Button {
                isShowingAddSheet = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title3)
                    .foregroundStyle(.white)
            }
        }
        .sheet(isPresented: $isShowingAddSheet) {
            AddPlantView(roomID: room.id)
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
            self.plants = try await PlantService.shared.fetchPlants(forRoomID: room.id)
            self.isLoading =  false
        } catch {
            self.errorMessage = "Could not load plants"
            self.isLoading = false
        }
    }
}

