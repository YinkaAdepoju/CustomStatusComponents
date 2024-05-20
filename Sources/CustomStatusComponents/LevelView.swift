//
//  LevelView.swift
//
//
//  Created by Yinka Adepoju on 19/5/24.
//

import SwiftUI

public struct LevelView: View {
    private let fontSize: CGFloat = 12
    private let grayColor: Color = .gray
    private let whiteColor: Color = .white

    public init() {}

    public var body: some View {
        HStack(spacing: 0) {
            Text("LVL")
                .font(.custom("DrukCyr-Heavy", size: fontSize))
                .foregroundColor(grayColor)
            Text("99")
                .font(.custom("DrukCyr-Heavy", size: fontSize))
                .foregroundColor(whiteColor)
        }
    }
}

