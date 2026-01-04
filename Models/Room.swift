import Foundation

struct Room: Identifiable, Codable {
    let id: Int
    let name: String
    
    // Computed property for UI (Optional fun)
    var icon: String {
        switch name {
        case "Bedroom": return "bed.double.fill"
        case "Kitchen": return "fork.knife"
        case "Living Room": return "house.fill"
        default: return "house.fill"
        }
    }
}
