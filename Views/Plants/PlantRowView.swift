import SwiftUI

struct PlantRowView: View {
    let plant: Plant
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: plant.image_url)) { phase in
                switch phase {
                case.empty:
                    ProgressView()
                        .frame(width: 50, height: 50)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                @unknown default:
                    EmptyView()
                    
                }
            }
            
//            ZStack {
//                Circle()
//                    .fill(Color.green.opacity(0.1))
//                    .frame(width: 40, height: 40)
//                Image(systemName: "leaf.fill")
//                    .foregroundStyle(.green)
//            }
            VStack(alignment: .leading) {
                Text(plant.name)
                    .font(.headline)
                Text("Water every \(plant.water_frequency) days")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if plant.water_frequency < 5 {
                Image(systemName: "drop.fill")
                    .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 4)
    }
}
