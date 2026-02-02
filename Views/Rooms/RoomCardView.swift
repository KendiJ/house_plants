import SwiftUI

struct RoomCardView: View {
    let room: Room
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            ZStack {
                Color.gray.opacity(0.1)
                
                if let urlString = room.image_url, let url = URL(string: urlString) {
                    
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 120)
                                .clipped()
                        case .failure:
                            
                            Image(systemName: "house.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.green)
                        case .empty:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.green)
                }
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.4))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(room.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                Text("Tap for plants")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 2)
    }
}
