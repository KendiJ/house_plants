import SwiftUI

struct PlantDetailView: View {
    let plant: Plant
    
    // A fake "Last Watered" date for UI polish
    @State private var lastWatered = Date()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 1. Big Icon Header
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.1))
                        .frame(width: 150, height: 150)
                    
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .foregroundStyle(.green)
                }
                .padding(.top, 40)
                
                // 2. Plant Info
                Text("Room #\(plant.room_id)")
                    .foregroundStyle(.secondary)
                
                Divider()
                
                // 3. Water Schedule Card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Care schedule")
                        .font(.headline)
                    
                    HStack {
                        Image(systemName: "drop.fill")
                            .foregroundStyle(.blue)
                        Text("Water every \(plant.water_frequency) days")
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Interactive Element (Just for show right now)
                    DatePicker("Last watered", selection: $lastWatered, displayedComponents: .date)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
//#Preview {
//    PlantDetailView(plant: Plant(id: 1, name: "Test Plant", room_id: 1, water_frequency: 7))
//}
