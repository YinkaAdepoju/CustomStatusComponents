//
//  CustomStatusBar.swift
//
//
//  Created by Yinka Adepoju on 19/5/24.
//

import SwiftUI

public struct CustomStatusBar: View {
    public var image: Image
    public var fullnessLevel: Float
    @Binding public var isPlusTapped: Bool

    private let horizontalPadding: CGFloat = 20
    private let verticalPadding: CGFloat = 14
    private let spacerMinWidth: CGFloat = 0
    private let spacerMaxWidth: CGFloat = 135
    private let barHeight: CGFloat = 48

    public init(image: Image, fullnessLevel: Float, isPlusTapped: Binding<Bool>) {
        self.image = image
        self.fullnessLevel = fullnessLevel
        self._isPlusTapped = isPlusTapped
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                ChatIndicatorView()
                AgeView()
                Spacer().frame(minWidth: spacerMinWidth, maxWidth: spacerMaxWidth)
                LevelView()
                FullnessIndicatorView(
                    image: image,
                    fullnessLevel: fullnessLevel,
                    isPlusTapped: $isPlusTapped
                )
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.top, verticalPadding)
            .padding(.bottom, verticalPadding)
            .background(Color.clear)
            Spacer(minLength: 0)
        }
        .frame(height: barHeight)
        .background(Color.black)
        .edgesIgnoringSafeArea(.top)
    }
}

