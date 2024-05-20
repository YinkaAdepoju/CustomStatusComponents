# CustomStatusComponents

[![Swift](https://img.shields.io/badge/swift-5.5-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platforms-iOS_17%2B-blue.svg)](https://developer.apple.com/ios/)

CustomStatusComponents is a Swift package that provides reusable SwiftUI components for displaying custom status bars, fullness indicators, chat indicators, age views, and level views.

## Requirements

- iOS 17.0+
- Swift 5.5+

## Installation

### Swift Package Manager

To integrate CustomStatusComponents into your Xcode project using Swift Package Manager, follow these steps:

1. Open your project in Xcode.
2. Go to `File > Swift Packages > Add Package Dependency`.
3. Enter the repository URL: `https://github.com/YinkaAdepoju/CustomStatusComponents.git`.
4. Select the package and add it to your project.

### Usage

1. Import the package:

    ```swift
    import CustomStatusComponents
    ```

2. Use the provided components in your SwiftUI views:

    ```swift
    import SwiftUI
    import CustomStatusComponents

    struct ContentView: View {
        @State private var isPlusTapped = false

        var body: some View {
            VStack {
                CustomStatusBar(
                    image: Image("iris-uid"),
                    fullnessLevel: 0.75, //to adjust the value of the battery
                    isPlusTapped: $isPlusTapped
                )
                Spacer()
                // Use other components as needed
                ChatIndicatorView()
                AgeView()
                LevelView()
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true) // Hide the default iOS status bar
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    ```

## Components

### `FullnessIndicatorView`

A view that displays a fullness indicator with a profile image, fullness bars, and a plus button.

- **Parameters:**
  - `image`: A `SwiftUI.Image` to display as the profile image.
  - `fullnessLevel`: A `Float` value between 0.0 and 1.0 representing the fullness level.
  - `isPlusTapped`: A `Binding<Bool>` that changes when the plus button is tapped.

### `CustomStatusBar`

A custom status bar that includes the `ChatIndicatorView`, `AgeView`, `LevelView`, and `FullnessIndicatorView`.

- **Parameters:**
  - `image`: A `SwiftUI.Image` to display as the profile image in the fullness indicator.
  - `fullnessLevel`: A `Float` value between 0.0 and 1.0 representing the fullness level in the fullness indicator.
  - `isPlusTapped`: A `Binding<Bool>` that changes when the plus button in the fullness indicator is tapped.

### `ChatIndicatorView`

A view that displays a chat indicator with a message icon and status dots.

### `AgeView`

A view that displays the age with a customizable label.

### `LevelView`

A view that displays the level with a customizable label.

## License

CustomStatusComponents is released under the MIT license. See [LICENSE](LICENSE) for details.
