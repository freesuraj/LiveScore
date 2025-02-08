# LiveScore

LiveScore is an iOS application that provides live scores and match details for various sports fixtures. The app is built using Swift and SwiftUI, and it fetches data from a remote API.

## Features

- View a list of upcoming, in-progress, and completed fixtures.
- Search for fixtures by team name.
- View detailed match information, including team logos, scores, and goal timelines.
- Automatic data refresh every 30 seconds.

## Project Structure

```
LiveScore/
├── App/
│   └── LiveScoreApp.swift
├── Assets.xcassets/
│   ├── AccentColor.colorset/
│   ├── AppIcon.appiconset/
│   └── Contents.json
├── Domain/
│   └── Models/
├── Features/
│   ├── Common/
│   └── Scores/
├── Network/
│   ├── APIClient.swift
│   ├── APIConfig.swift
│   ├── Endpoints.swift
│   └── NetworkError.swift
├── Preview Content/
├── Utils/
├── LiveScore.xcodeproj/
├── LiveScoreTests/
│   └── LiveScoreTests.swift
└── LiveScoreUITests/
    ├── LiveScoreUITests.swift
    └── LiveScoreUITestsLaunchTests.swift
```

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/freesuraj/LiveScore.git
    ```
2. Open the project in Xcode:
    ```sh
    cd LiveScore
    open LiveScore.xcodeproj
    ```
3. Build and run the project on your simulator or device.

## Usage

- Launch the app to view the list of fixtures.
- Tap on a fixture to view detailed match information.
- Use the search bar to filter fixtures by team name.

## How to Run the Project

1. Ensure you have latest version of Xcode (Xcode 16) installed on your Mac.
2. Clone the repository and open the project in Xcode.
3. Select the target device (simulator or physical device).
4. Click on the "Run" button or press `Cmd + R` to build and run the project.

## Assumptions Made

- The app assumes that the remote API is available and provides the necessary endpoints for fetching fixture data.
- The app assumes that the user has an active internet connection to fetch live scores and match details.
- The app assumes that the data returned by the API is in the expected format and contains all required fields.
