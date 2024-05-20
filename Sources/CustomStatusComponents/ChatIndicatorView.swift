//
//  File.swift
//
//
//  Created by Yinka Adepoju on 19/5/24.
//

import SwiftUI

public struct ChatIndicatorView: View {
    public init() {}

    public var body: some View {
        HStack(spacing: 4) { // Increased spacing
            Image(systemName: "message.fill")
                .foregroundColor(.white)
                .font(.system(size: 12)) // Adjusted size
            ForEach(0..<4) { _ in
                Circle()
                    .fill(Color.gray)
                    .frame(width: 4, height: 7) // Adjusted size
            }
        }
        .padding(4)
        .background(Color.black)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.gray, lineWidth: 1)) // Gray stroke around the component
    }
}
