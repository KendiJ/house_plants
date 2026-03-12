import SwiftUI

struct PlantDetailView: View {
    let plant: Plant
    let roomName: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack {
                    if let url = URL(string: plant.image_url) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            default:
                                Color.green.opacity(0.2)
                            }
                        }
                    } else {
                        Color.green.opacity(0.2)
                    }
                }
                .frame(height: 450)
                .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(plant.name)
                        .font(.system(size: 36, weight: .bold, design: .serif))
                        .foregroundStyle(.primary)
                    
                    HStack {
                        Image(systemName: "house.fill")
                            .foregroundStyle(.green)
                        Text(roomName)
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                }
                Divider()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Care Schedule")
                        .font(.headline)
                    
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 50, height: 50)
                            Image(systemName: "drop.fill")
                                .font(.title2)
                                .foregroundStyle(.blue)
                        }
                        VStack(alignment: .leading) {
                            Text("Watering")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("Every \(plant.water_frequency) days")
                                .font(.headline)
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("About")
                        .font(.headline)
                    Text("This beautifu \(plant.name) is a perfect addition to your \(roomName). It thrives in medium to bright indirect light. Remember to let the top inch of soil dry out between waterings to keep it happy and healthy.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .lineSpacing(4)
                }
            }
            .padding(30)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .offset(y: -50)
            .padding(.bottom, -50)
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title3.weight(.bold))
                    .padding(10)
                    .background(Color(.systemBackground))
                    .foregroundStyle(.primary)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
            .safeAreaPadding(.top)
            .padding(.leading, 16)
        }
    }
    
}
