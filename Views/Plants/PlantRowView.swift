import SwiftUI

struct PlantRowView: View {
    let plant: Plant
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: "leaf.fill")
                    .foregroundStyle(.green)
            }
            VStack(alignment: .leading) {
                Text(plant.name)
                    .font(.headline)
                Text("Water every \(plant.water_frequency) days")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
