# MSE Assignment - Flutter App

This application featuring GitHub pull request integration, and responsive UI with MVVM architecture.

## Features

- **Login Screen** - Secure authentication with token storage
- **Pull Requests** - Fetch and display GitHub pull requests
- **Dark/Light Theme** - Automatic theme switching
- **Animations** - Smooth page transitions and loading effects
- **Responsive UI** - Works on all screen sizes

## Tech Stack

- **Flutter** (^3.10.1) - UI framework
- **GetX** (^5.0.0) - State management & routing
- **HTTP** (^1.6.0) - API calls
- **intl** (^0.20.2) - Date formatting
- **Flutter Secure Storage** (^9.2.4) - Secure token storage
- **Shimmer** (^3.0.0) - Loading animations
- **Connectivity Plus** (^7.0.0) - Internet checking

## Project Structure

```
lib/
├── main.dart
├── assignment/
│   ├── modules/
│   │   ├── login_screen/      # Login feature
│   │   └── pull_request/      # Pull Request display feature
│   ├── data/
│   │   ├── model/             # Data models
│   │   └── service/           # API service
│   └── routes/                # Navigation
└── core/
    ├── app_theme.dart
    └── storage_data.dart
```

## API Used

- GitHub: `https://api.github.com/repos/Ranjan221120/Bloc/pulls`

## Project Statistics

- **Total Dependencies**: 6 packages
- **Architecture Pattern**: MVVM + GetX
- **Code Organization**: Modular & feature-based
- **Themes Supported**: 2 (Light & Dark)
- **API Integrations**: 1 (GitHub)

## Implemented
- Clean Architecture   
- Reactive programming with GetX bindings  
- Secure storage data  
- Error handling
- Checking Internet connections
- Loading states
- Themes 
- Responsive UI that works across devices  
- Network request management
