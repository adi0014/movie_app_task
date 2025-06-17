# Flutter Movie App

This is a Flutter application that displays trending and now playing movies using the TMDB API. It allows users to search, view movie details, bookmark movies, and share them through deep links.

## Features

- Display trending movies
- Display now playing movies
- Movie detail screen with poster and overview
- Bookmark movies locally using Hive
- Offline support for bookmarks
- Search functionality with debounce
- Share movie detail using system share sheet
- Deep linking support for navigating to movie details
- Error handling for network and API failures
- State management using Riverpod
- Clean MVVM architecture with repository pattern

## Project Structure
lib/
├── core/
│ └── constants/
├── data/
│ ├── local/
│ ├── models/
│ ├── remote/
│ └── repository/
├── presentation/
│ ├── screens/
│ └── viewmodels/



## Setup Instructions

1. Clone the repository

2. Install dependencies


3. Generate files using build_runner


4. TMDB API key is already provided in `movie_repository.dart` and hardcoded in `main.dart`


5. Run the app


## Requirements

- Flutter SDK 3.32.4
- Dart SDK 3.8.1
- Android Studio or VS Code
- Internet connection (Mobile) (for API access)

## Notes

- The app supports Android and Web
- For offline access, only bookmarked movies are stored locally
- On some public Wi-Fi, TMDB API might not load; switch to mobile data if needed

## Author

Aditya Mishra  
Email: adityaamishraaa14@gmail.com


