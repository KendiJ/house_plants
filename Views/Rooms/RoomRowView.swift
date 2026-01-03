import SwiftUI

struct RoomRowView: View {
    let room : Room
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 40, height: 40)
                Image(systemName: room.icom)
                    .foregroundStyle(.green)
            }
            
            VStack(alignment.leading) {
                Text(room.name)
                    .font(.headline)
                Text("Tap to see plants")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.grey)
        }
        .paddint(.vertical, 4)
    }
}

// Preview provider (like hot-reload)
#Preview {
    RoomRowView(room: Room(id: 1, name: "Living Room"))
}
