//
//  FullnessIndicatorView.swift
//
//
//  Created by Yinka Adepoju on 19/5/24.
//

import SwiftUI

public struct PlusShape: Shape {
    public init() {}

    public func path(in rect: CGRect) -> Path {
        let lineThickness: CGFloat = rect.width * 0.3 // Increased thickness
        let halfLineThickness = lineThickness / 2
        let halfWidth = rect.width / 2
        let halfHeight = rect.height / 2

        var path = Path()

        // Horizontal line
        path.addRoundedRect(in: CGRect(x: 0, y: halfHeight - halfLineThickness, width: rect.width, height: lineThickness), cornerSize: CGSize(width: halfLineThickness, height: halfLineThickness))

        // Vertical line
        path.addRoundedRect(in: CGRect(x: halfWidth - halfLineThickness, y: 0, width: lineThickness, height: rect.height), cornerSize: CGSize(width: halfLineThickness, height: halfLineThickness))

        return path
    }
}

public struct FullnessIndicatorView: View {
    public var image: Image
    public var fullnessLevel: Float // Ranges from 0.0 to 1.0
    @Binding public var isPlusTapped: Bool
    @State private var isPulsing = false

    private let spacing: CGFloat = 4
    private let imageSize: CGFloat = 14
    private let strokeWidth: CGFloat = 1
    private let barWidth: CGFloat = 4 // Increased width
    private let barHeight: CGFloat = 12 // Increased height
    private let plusButtonSize: CGFloat = 10 // Increased size
    private let padding: CGFloat = 4
    private let strokeColor: Color = .gray
    private let backgroundColor: Color = .black
    private let plusBackgroundColor: Color = .white

    public init(image: Image, fullnessLevel: Float, isPlusTapped: Binding<Bool>) {
        self.image = image
        self.fullnessLevel = fullnessLevel
        self._isPlusTapped = isPlusTapped
    }

    public var body: some View {
        Button(action: {
            isPlusTapped.toggle()
        }) {
            HStack(spacing: spacing) {
                // Profile Image
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(strokeColor, lineWidth: strokeWidth))

                // Fullness Bars
                HStack(spacing: 3) {
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(getBarColor(for: index))
                            .frame(width: barWidth, height: barHeight)
                            .opacity(fullnessLevel == 0 ? (isPulsing ? 0.5 : 1) : 1)
                    }
                }
                .onAppear {
                    if fullnessLevel == 0 {
                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            isPulsing.toggle()
                        }
                    }
                }

                // Plus Button
                PlusShape()
                    .foregroundColor(.black)
                    .frame(width: plusButtonSize, height: plusButtonSize)
                    .padding(2)
                    .background(plusBackgroundColor)
                    .clipShape(Circle())
            }
            .padding(padding)
            .background(backgroundColor)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(strokeColor, lineWidth: strokeWidth))
        }
    }
    
    private func getBarColor(for index: Int) -> Color {
        let numberOfBars: Int
        switch fullnessLevel {
        case 0:
            return .white // Default color when level is 0
        case 0.01...0.25:
            numberOfBars = 1
        case 0.26...0.50:
            numberOfBars = 2
        case 0.51...0.75:
            numberOfBars = 3
        case 0.76...1.0:
            numberOfBars = 4
        default:
            numberOfBars = 0
        }
        return index < numberOfBars ? .white : .gray
    }
}

public struct FullnessIndicatorModifier: ViewModifier {
    var image: Image
    var fullnessLevel: Float
    @Binding var isPlusTapped: Bool

    public func body(content: Content) -> some View {
        ZStack {
            content
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomStatusBar(
                    image: image,
                    fullnessLevel: fullnessLevel,
                    isPlusTapped: $isPlusTapped
                )
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

public extension View {
    func fullnessIndicator(image: Image, fullnessLevel: Float, isPlusTapped: Binding<Bool>) -> some View {
        self.modifier(FullnessIndicatorModifier(image: image, fullnessLevel: fullnessLevel, isPlusTapped: isPlusTapped))
    }
}
