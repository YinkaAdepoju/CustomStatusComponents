//
//  AgeView.swift
//
//
//  Created by Yinka Adepoju on 19/5/24.
//

import SwiftUI

public struct AgeView: View {
    public init() {}

    public var body: some View {
        HStack(spacing: 0) {
            Text("AGE")
                .font(.custom("DrukCyr-Bold", size: 12)) // Slightly smaller size
                .foregroundColor(.gray) // Gray color
            Text("21")
                .font(.custom("DrukCyr-Bold", size: 12)) // Slightly smaller size
                .foregroundColor(.white) // White color
        }
    }
}

