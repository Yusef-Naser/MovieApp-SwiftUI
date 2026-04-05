## MovieApp SwiftUI
A modularized iOS application built with SwiftUI, Combine, and SwiftData. The project follows a Layer-based (Horizontal) modular architecture to ensure a clear separation of concerns and high testability.

## Getting Started
Open Workspace: Always open MovieApp-SwiftUI.xcworkspace.

Run App: Select the MovieApp-SwiftUI scheme.

Run Tests: Select the LogicScenes scheme to execute Unit Tests for ViewModels.

# Modular Architecture
The app is split into several independent frameworks (modules) to isolate logic and improve build times.

## MovieApp-Network
The core networking layer responsible for API communication.

ApiClient: A centralized service using Combine for data fetching.

Requests: Dedicated objects for DiscoverMovies, DetailsMovie, and getGenre.

Error Handling: Custom NetworkError type to map API and system errors.

## MovieApp-Entities
Contains the data structures used throughout the application.

API Entities: Codable structs that map directly to JSON responses.

SwiftData Entities: Persistent @Model classes for offline storage.

## MovieApp-Dependencies
A wrapper layer used to decouple the codebase from third-party libraries.

SDWebImageSwiftUI: Isolated via a LoadImageWrapper.

Benefit: Allows switching image-loading libraries without touching the UI code.

## MovieApp-Utilities
A collection of helpers, extensions, and reusable UI modifiers.

AlertModifier: A centralized way to trigger system alerts.

Constants: Manages BaseUrl, APIKey, and environment configurations.

CustomProgress: Reusable loading indicators.

DebugViewModifier: A diagnostic tool that logs view lifecycle events (Appear/Disappear).

## UIScenes (Presentation Layer)
Contains all SwiftUI Views. This module focuses purely on the UI and layout for:

Discover Screen: Browsing movies.

Details Screen: Viewing in-depth information about a specific title.

## LogicScenes (Domain & Data Layer)
The bridge between the data and the UI.

ViewModels: Manage state and user intent for the screens.

Repositories: Handle the logic of choosing between Network and SwiftData (Offline-first approach).

Note: This layer is prepared to support a "Domain/UseCase" layer if complex business logic is needed in the future.

## Future Roadmap: Vertical Modularization
While the current setup is horizontal, We can transition to Feature-based (Vertical) modules.


# Tech Stack
UI: SwiftUI

Reactive: Combine

Persistence: SwiftData

Networking: URLSession

Dependency Management: Modular Frameworks (Local)
