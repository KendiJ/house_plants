import Foundation

struct Plant: Identifiable, Codable {
    let id: Int
    let name: String
    let room_id: Int
    let water_frequency: Int
    let image_url: String
}
