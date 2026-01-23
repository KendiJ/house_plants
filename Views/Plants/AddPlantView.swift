import SwiftUI

struct AddPlantView: View {
    let roomID: Int
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = "Monstera"
    @State private var waterFreq: Int = 7
    @State private var selectedImage: String = "https://images.unsplash.com/photo-1614594975525-e45190c55d0b?auto=format&fit=crop&w=600&q=80"
    let plantData: [String: String] = [
            "Monstera": "https://images.unsplash.com/photo-1614594975525-e45190c55d0b?auto=format&fit=crop&w=600&q=80",
            "Snake Plant": "https://images.unsplash.com/photo-1599598425947-d35241776d63?auto=format&fit=crop&w=600&q=80",
            "Basil": "https://images.unsplash.com/photo-1618331835717-801e976710b2?auto=format&fit=crop&w=600&q=80",
            "Pothos": "https://images.unsplash.com/photo-1596726915852-6e2c388d7524?auto=format&fit=crop&w=600&q=80",
            "Fiddle Leaf Fig": "https://images.unsplash.com/photo-1617173944883-66bea4c56e2e?auto=format&fit=crop&w=600&q=80"
        ]
    
    var plantTypes: [String] {
            plantData.keys.sorted()
        }
    
    var body: some View {
        NavigationStack {
            Section("Plant Details") {
                Picker("Plant Type", selection: $name) {
                    ForEach(plantTypes, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                
                .onChange(of: name) { newName in
                    if let newURL = plantData[newName] {
                        selectedImage = newURL
                    }
                }
                Stepper("Water every\(waterFreq) days", value: $waterFreq, in: 1...30)
            }
            Section("Privew") {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: selectedImage)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    Spacer()
                }
            }
        }
        .navigationTitle("Add new plant")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Save") {
                    Task {
                        do {
                            try await PlantService.shared.addPlant(
                                name: name,
                                roomID: roomID,
                                waterFreq: waterFreq,
                                imageURL: selectedImage
                            )
                            dismiss()
                        } catch {
                            print("Error saving plant: \(error)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddPlantView(roomID: 1)
}
