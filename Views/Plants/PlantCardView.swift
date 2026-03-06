import SwiftUI

struct PlantCardView: View {
    let plant: Plant
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: plant.image_url)) { phase in
                switch phase {
                    case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                default:
                    ZStack {
                        Color.green.opacity(0.1)
                        Image(systemName: "leaf.fill")
                            .foregroundStyle(Color.green)
                    }
                    .frame(width: 80, height: 80)
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(plant.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                HStack {
                    Image(systemName: "drop.fill")
                        .font(.caption)
                        .foregroundStyle(.blue)
                    Text("Every \(plant.water_frequency) days")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray.opacity(0.5))
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
