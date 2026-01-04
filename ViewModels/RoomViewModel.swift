import Foundation

//@MainActor ensures UI updates happen on the main thread (Vital!)
@MainActor
class RoomViewModel: ObservableObject {
    // @Published: Then this changes the UI redraws automatically
    @Published var rooms: [Room] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchRooms() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // call your service
            self.rooms = try await PlantService.shared.fetchRooms()
        } catch {
            self.errorMessage = "Failed to load rooms: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
