import SwiftUI

struct RoomRowView: View {
    let room : Room
    
    var body: some View {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.2))
                        .frame(width: 40, height: 40)
                    Image(systemName: room.icon)
                        .foregroundStyle(.green)
                }
                
                VStack(alignment: .leading) {
                    Text(room.name)
                        .font(.headline)
                        .foregroundStyle(.black)
                    Text("Tap to see plants")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
//                Image(systemName: "arrow.right")
//                    .foregroundStyle(.black.opacity(0.5))
            }
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
        }
}
