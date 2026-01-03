import Foundation

// The "Error" enum
enum NetworkError: Error {
    case badURL, requestFailed, decodingError
}

class PlantService {
    static let shared = PlantService()
    
    func fetchPlants() async throws -> [Room] {
        guard let url = URL(string: "http://localhost:8080/rooms") else {
            throw NetworkError.badURL
        }
        // 1. Fetch Data
        let(data, response) = try await URLSession.shared.data(from: url)
        
        // 2. Check Status Code
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        // 3. Decode JSON
        do {
            let rooms = try JSONDecoder().decode([Room].self, from: data)
            return rooms
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
}
}
