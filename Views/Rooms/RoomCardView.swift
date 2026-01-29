
// Source - https://stackoverflow.com/a/79298549
// Posted by Andrei G., modified by community. See post 'Timeline' for change history
// Retrieved 2026-01-28, License - CC BY-SA 4.0

import SwiftUI


//MARK: - Main view

struct CustomArtistCard: View {
    
    //State values
    @State private var artistName: String = "Artist"
    @State private var isLiked: Bool = false

    //Form states
    @State private var selectedElement: ElementType = .rect
    @State private var backgroundHue: Double = 0.5
    @State private var elementSize: Double = 1.0
    
    //Computed properties
    private var currentColor: Color {
        Color(hue: backgroundHue, saturation: 0.5, brightness: 0.9)
    }
    
    //Body
    var body: some View {
        
        
        VStack(spacing: 40) {
            
            Spacer()
            
            ArtistCard(image: "") // <- Specify your named image from Assets here
            
                //MARK: - Top left
            
//                .overlay(alignment: .topLeading) {
//                    Text("Music")
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 5)
//                        .background(.white, in: Capsule())
//                        .padding(10)
//                        .roundCorners(.fill) {
//                            RoundCorner(radius: 20, alignment: .bottomTrailing, orientation: .bottomTrailing, position: .inside, flip: .trailing)
//                        }
//                        .roundCorners {
//                            RoundCorner(radius: 20, alignment: .bottomLeading, orientation: .topLeading, position: .outside, flip: .bottom)
//                            RoundCorner(radius: 20, alignment: .topTrailing, orientation: .topLeading, position: .outside, flip: .trailing)
//                        }
//                }
            
                //MARK: - Bottom right
                
                .overlay(alignment: .bottomTrailing) {
                    
                    Group {
                        
                        //MARK: - Singer name
                        
//                        if selectedElement == .rect {
//                            
//                            if artistName != "" {
//                                Text(artistName)
//                                    .padding(.horizontal, 10)
//                                    .padding(.vertical, 5)
//                                    .background(.gray.opacity(0.2), in: Capsule())
//                                    .padding(.horizontal, 5)
//                                    .padding(.vertical, 5)
//                                    .background(.white, in: RoundedRectangle(cornerRadius: 16))
//                                    .padding(10)
//                            }
//                            else {
//                                EmptyView()
//                            }
//                        }
                        
                        //MARK: - Like button
                        
//                        else {
//                            
//                            //Like button
//                            Button {
//                                isLiked.toggle()
//                            } label: {
//                                withAnimation(.interactiveSpring) {
//                                    Image(systemName: isLiked ? "heart.fill" : "heart")
//                                }
//                            }
//                            .tint(isLiked ? .red : .gray)
//                            .padding(10)
//                            .background(.white.opacity(0.7), in: Circle())
//                            .padding(5)
//                        }
                    }
                    .roundCorners(.fill) {
                        RoundCorner(radius: 20, alignment: .topLeading, orientation: .topLeading, position: .inside)

                    }
                    .roundCorners {
                        RoundCorner(radius: 20, alignment: .bottomLeading, orientation: .bottomTrailing, position: .outside, flip: .leading)
                        RoundCorner(radius: 20, alignment: .topTrailing, orientation: .bottomTrailing, position: .outside, flip: .top)
                    }
                    .scaleEffect(elementSize, anchor: .bottomTrailing)
                    
                }
                .compositingGroup()
                .animation(.easeInOut, value: selectedElement)
                .animation(.default, value: artistName)
            
            
            //MARK: - Demo Controls
            
            Form {
                
                Section("Element type") {
                    Picker("Element", selection: $selectedElement) {
                        Text("Rectangle").tag(.rect as ElementType)
                        Text("Circle").tag(.circle as ElementType)
                    }
                    .pickerStyle(.segmented)
                }
                
                if selectedElement == .rect {
                    Section {
                        TextField("Change text...", text: $artistName)
                    } header: {
                        HStack {
                            Text("Change name")
                            Spacer()
                            Button {
                                withAnimation {
                                    artistName = ""
                                }
                            } label: {
                                Text("Clear")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .transition(.blurReplace)
                }
                
                //MARK: - Slider - Background color
                
                Section {
                    HStack {
                        Slider(value: $backgroundHue, in: 0...1) {
                            Text("Background color")
                        }
                    }
                } header: {
                    HStack(alignment: .center) {
                        Text("Background color")
                        Spacer()
                        
                        //Reset button
                        if backgroundHue != 0.5 {
                            Button {
                                withAnimation {
                                    backgroundHue = 0.5
                                }
                            } label: {
                                Image(systemName: "gobackward")
                                    .imageScale(.small)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                //MARK: - Slider - Element size
                
                Section {
                    Slider(value: $elementSize, in: 0.5...2) {
                        Text("Background color")
                    }
                } header: {
                    HStack(alignment: .center) {
                        Text("Element size")
                        Spacer()
                        
                        //Reset button
                        if elementSize != 1.0 {
                            Button {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    elementSize = 1.0
                                }
                            } label: {
                                Image(systemName: "gobackward")
                                    .imageScale(.small)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .scrollContentBackground(.hidden)
            .animation(.easeInOut, value: selectedElement)
            .tint(currentColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background {
            currentColor
                .ignoresSafeArea()
        }
        .animation(.smooth(duration: 2.0), value: backgroundHue)
    }
    
}

//MARK: - Artist card view

struct ArtistCard: View {
    
    var image: String = ""
    
    var body: some View {
        
        Group {
            if image != "" {
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
            else {
                Color.blue
            }
        }
        .frame(width: 300, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

//MARK: - Arc Shape

struct RoundCornerArc: Shape {
    
    //Parameters
    var radius: CGFloat = 120
    
    //Path
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            // Define points
            let start = CGPoint(x: rect.minX, y: rect.maxY) // Bottom-left corner
            let end = CGPoint(x: rect.maxX, y: rect.minY)    // Top-right corner
            
            // Start drawing
            path.move(to: start) // Start at bottom-left
            path.addArc(tangent1End: .zero, tangent2End: end, radius: radius) //Add arc to top-right
            path.addLine(to: .zero) // Draw vertical line to top-left
            path.closeSubpath() //Close the path to bottom-left point
        }
    }
}

//MARK: - View extension

extension View {
    
    func roundCorners<Corners: View>(_ mode: RoundCorner.MaskMode = .mask,
        @ViewBuilder corners: () -> Corners
    ) -> some View {
        self.modifier(RoundCornersViewModifier(mode: mode, corners: corners))
    }
}

//MARK: - View modifier

struct RoundCornersViewModifier<Corners: View>: ViewModifier {
    
    //Parameters
    var mode: RoundCorner.MaskMode = .mask
    @ViewBuilder let corners: Corners
    
    //ViewModifier body
    func body(content: Content) -> some View {
        content
            .background {
                if mode == .fill {
                    Rectangle()
                        .overlay {
                            corners
                        }
                        .compositingGroup()
                        .blendMode(.destinationOut)
                }
            }
            .overlay {
                if mode == .mask {
                    corners
                }
            }
    }
    
    
}

//MARK: - RoundCorner view

struct RoundCorner: View {
    
    public enum MaskMode {
        case mask, fill
    }
    
    //Parameters
    var radius: CGFloat = 20
    var alignment: Alignment = .topLeading
    var orientation: Alignment = .topLeading
    var position: MaskPosition = .inside
    var flip: Edge = .leading
    var blend: Bool = true
    var fill: Color?
    var preview: Bool = false
    var previewColor: Color = .black
    var mode: String = ""
    
    //Computed properties
    private var rotation: Angle {
        switch orientation {
            case .topLeading: return .degrees(0)
            case .bottomTrailing: return .degrees(-180)
            case .topTrailing: return .degrees(90)
            case .bottomLeading: return .degrees(-90)
            default: return .degrees(0)
        }
    }
    
    private var offsetX: CGFloat {
        switch position {
            case .inside:
                switch flip {
                    case .top:
                        return 0
                    case .bottom:
                        return 0
                    case .trailing:
                        return 0
                    case .leading:
                        return 0
                }
            case .outside:
                switch flip {
                    case .top:
                        return 0
                    case .bottom:
                        return 0
                    case .trailing:
                        return radius
                    case .leading:
                        return -radius
                }
        }
    }
    
    private var offsetY: CGFloat {
        switch position {
            case .inside:
                switch flip {
                    case .top:
                        return 0
                    case .bottom:
                        return 0
                    case .trailing:
                        return 0
                    case .leading:
                        return 0
                }
            case .outside:
                switch flip {
                    case .top:
                        return -radius
                    case .bottom:
                        return radius
                    case .trailing:
                        return 0
                    case .leading:
                        return 0
                }
        }
    }
    
    //View body
    var body: some View {
        Color.clear
            .overlay(alignment: alignment) {
                RoundCornerArc(radius: radius)
                    .fill(preview ? previewColor : fill ?? .black)
                    .frame(width: radius, height: radius)
                    .rotationEffect(rotation)
                    .blendMode(preview ? .normal : blend ? .destinationOut : .normal)
                    .border(preview ? previewColor : .clear)
                    .offset(x: offsetX, y: offsetY)
            }
    }
}


//MARK: - MaskPosition enum for view modifier

enum MaskPosition {
    case inside, outside
}

//MARK: - Helper enum for form controls

enum ElementType {
    case rect, circle
}

//Test view for alternate preview
struct RoundCornerTest: View {
    
    //State values
    @State private var debug: Bool = false
    
    //Computed properties
    private var preview: Bool {
        !debug
    }
    
    //Body
    var body: some View {
        
        VStack {
            
            //Example 1 - Simple
            Rectangle()
                .fill(.yellow)
                .frame(width: 200, height: 200)
                .roundCorners {
                    
                    //Round corner - Inside - Top left
                    RoundCorner(radius: 40, alignment: .topLeading, orientation: .topLeading, position: .inside, flip: .top, blend: true, preview: preview, previewColor: .black)
                        
                    //Round corner - Outside - Top right
                    RoundCorner(radius: 80, alignment: .topTrailing, orientation: .bottomTrailing, position: .outside, flip: .top, blend: false, fill:  .yellow,  preview: preview, previewColor: .pink)
                }
                .compositingGroup()
                .padding(.bottom, 50)

            
            //Example 2 - Advanced
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame(width: 200, height: 200)
                .overlay(alignment: .bottom) {
                    
                    //Place rectangle at the bottom
                    Rectangle()
                        .fill(.white)
                        .frame(width: 75, height: 75)
                        .roundCorners {
                            
                            //Round corners - Top left
                            RoundCorner(radius: 40, alignment: .topLeading, orientation: .bottomLeading, position: .outside, flip: .top, preview: preview, previewColor: .yellow)
                            RoundCorner(radius: 30, alignment: .topLeading, orientation: .topTrailing, position: .outside, flip: .leading, preview: preview, previewColor: .red)
                            RoundCorner(radius: 20, alignment: .topLeading, orientation: .topLeading, position: .inside, preview: preview, previewColor: .orange)
                            
                            // Round corners - Top right
                            RoundCorner(radius: 40, alignment: .topTrailing, orientation: .bottomTrailing, position: .outside, flip: .top, preview: preview, previewColor: .pink)
                            RoundCorner(radius: 30, alignment: .topTrailing, orientation: .topLeading, position: .outside, flip: .trailing, preview: preview, previewColor: .indigo)
                            RoundCorner(radius: 20, alignment: .topTrailing, orientation: .topTrailing, position: .inside, preview: preview, previewColor: .orange)
                            
                            //Round corners - Bottom left
                            RoundCorner(radius: 40, alignment: .bottomLeading, orientation: .bottomTrailing, position: .outside, flip: .leading, preview: preview, previewColor: .green)
                            
                            //Round corners - Bottom right
                            RoundCorner(radius: 40, alignment: .bottomTrailing, orientation: .bottomLeading, position: .outside, flip: .trailing, preview: preview, previewColor: .teal)
                        }
                        .animation(.default, value: preview)
                }
                .compositingGroup()
                .padding(.bottom, 20)
            
            
            //Preview toggle
            Toggle("Preview", isOn: $debug)
                .fixedSize()
                .padding()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("CustomArtistCard Demo") {
    CustomArtistCard()
}

#Preview("RoundCorner Test") {
    RoundCornerTest()
}

#Preview("Arc Shape") {
    RoundCornerArc()
        .frame(width: 100, height: 100, alignment: .center)
        .foregroundStyle(.yellow)
}

#Preview("Artist Card") {
    ArtistCard() // or ArtistCard(image: "") <- Specify your named image from Assets here
}

