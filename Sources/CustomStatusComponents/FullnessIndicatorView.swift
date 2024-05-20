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
        let lineThickness: CGFloat = rect.width * 0.2
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

    private let spacing: CGFloat = 4
    private let imageSize: CGFloat = 14
    private let strokeWidth: CGFloat = 1
    private let barWidth: CGFloat = 3
    private let barHeight: CGFloat = 7
    private let plusButtonSize: CGFloat = 8
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
                        .opacity(fullnessLevel == 0 && index == 0 ? animatePulsing() : 1)
                }
            }

            // Plus Button
            Button(action: {
                isPlusTapped.toggle()
            }) {
                PlusShape()
                    .foregroundColor(.black)
                    .frame(width: plusButtonSize, height: plusButtonSize)
                    .padding(2)
                    .background(plusBackgroundColor)
                    .clipShape(Circle())
            }
        }
        .padding(padding)
        .background(backgroundColor)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(strokeColor, lineWidth: strokeWidth))
    }
    
    private func getBarColor(for index: Int) -> Color {
        switch fullnessLevel {
        case 0:
            return .red
        case 0.01...0.25:
            return index == 0 ? .red : .gray
        case 0.26...0.50:
            return index < 2 ? .orange : .gray
        case 0.51...0.75:
            return index < 3 ? .green : .gray
        case 0.76...1.0:
            return .green
        default:
            return .gray
        }
    }
    
    private func animatePulsing() -> Double {
        let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
        var opacity: Double = 1
        withAnimation(animation) {
            opacity = 0
        }
        return opacity
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
