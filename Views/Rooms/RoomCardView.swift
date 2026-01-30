import SwiftUI

struct RoomCardView: View {
    let room: Room
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                Color.green.opacity(0.1)
                
                Image(systemName: room.icon)
                    .font(.system(size: 30))
                    .foregroundStyle(.green)
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(room.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                Text("Tap to see plant")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
#Preview {
    RoomCardView(room: Room(id: 3, name: "Bed Room"))
        .padding()
        .background(Color.gray.opacity(0.2)) 
}
