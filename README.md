# 🌍 Travel AI - AI-Powered Travel Planner

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**An intelligent travel planning app powered by AI, built with Flutter**

[Features](#features) • [Screenshots](#screenshots) • [Getting Started](#getting-started) • [Architecture](#architecture) • [Contributing](#contributing)

</div>

---

## 📱 Screenshots

<div align="center">

<!-- Add your screenshots here -->
| Home Screen | Trip Planning | History | Settings |
|-------------|--------------|---------|----------|
| ![Home](screenshots/home.png) | ![Planning](screenshots/planning.png) | ![History](screenshots/history.png) | ![Settings](screenshots/settings.png) |

| Trip Details | Search | Weather | Dark Mode |
|--------------|--------|---------|-----------|
| ![Details](screenshots/details.png) | ![Search](screenshots/search.png) | ![Weather](screenshots/weather.png) | ![Dark](screenshots/dark.png) |

</div>

---

## ✨ Features

### 🤖 AI-Powered Planning
- **Smart Trip Generation**: AI-powered itinerary creation based on your preferences
- **Personalized Recommendations**: Tailored suggestions for destinations, activities, and accommodations
- **Intelligent Search**: Find destinations and trips with advanced search capabilities

### 🗺️ Trip Management
- **Complete Itineraries**: Day-by-day trip planning with activities and schedules
- **Budget Tracking**: Keep track of your travel expenses
- **Multiple Trip Types**: Support for adventure, leisure, business, family, and solo trips
- **Favorites**: Save and organize your favorite trips

### 🌤️ Weather Integration
- **Real-time Weather**: Current weather conditions for your destinations
- **Weather Forecasts**: Plan ahead with accurate weather predictions
- **Location-based Updates**: Automatic weather updates based on trip locations

### 📊 Trip History
- **Organized History**: View all your past trips in one place
- **Smart Filtering**: Filter by date, favorites, and trip type
- **Beautiful Cards**: Modern UI with trip cards showing key information

### ⚙️ Personalization
- **User Profiles**: Manage your personal information
- **Theme Modes**: Switch between light and dark themes
- **Multilingual**: Support for English and Hindi (more languages coming soon)
- **Settings Management**: Customize your app experience

### 🔐 Authentication
- **Email/Password**: Traditional authentication method
- **Google Sign-In**: Quick login with Google account
- **Secure**: Firebase Authentication for secure user management

---

## 🏗️ Architecture

TripTide follows **Clean Architecture** principles with a feature-first folder structure, ensuring scalability, maintainability, and testability.

### 📁 Project Structure

```
lib/
├── config/                    # App configuration
│   └── router/               # GoRouter navigation configuration
│
├── core/                      # Core functionality
│   ├── common/               # Shared utilities and helpers
│   ├── constants/            # App-wide constants
│   ├── enums/                # Enumerations
│   ├── extensions/           # Dart extensions
│   ├── theme/                # Theme configuration (light/dark)
│   └── utilities/            # Utility functions
│
├── l10n/                      # Localization files
│   ├── app_en.arb           # English translations
│   └── app_hi.arb           # Hindi translations
│
├── shared/                    # Shared across features
│   ├── models/               # Common data models
│   └── widgets/              # Reusable widgets
│
└── features/                  # Feature modules
    │
    ├── addtrip/              # Trip creation feature
    │   ├── mapper/           # Data mapping logic
    │   ├── models/           # Trip creation models
    │   ├── providers/        # Riverpod state management
    │   ├── repository/       # Data layer
    │   └── screens/          # UI screens
    │
    ├── auth/                 # Authentication feature
    │   ├── models/           # User models
    │   ├── providers/        # Auth state management
    │   ├── repository/       # Firebase auth repository
    │   └── screens/          # Login/signup screens
    │
    ├── history/              # Trip history feature
    │   ├── providers/        # History state management
    │   └── screens/          # History UI
    │       └── widgets/      # History-specific widgets
    │
    ├── search/               # Search feature
    │   ├── providers/        # Search state management
    │   ├── repository/       # Search data layer
    │   └── screens/          # Search UI
    │
    ├── settings/             # Settings feature
    │   ├── providers/        # Settings state management
    │   └── screens/          # Settings UI
    │       └── widgets/      # Settings widgets
    │
    ├── trip/                 # Trip details feature
    │   ├── models/           # Trip detail models
    │   ├── providers/        # Trip state management
    │   ├── repository/       # Trip data layer
    │   └── screens/          # Trip detail screens
    │       └── widgets/      # Trip-specific widgets
    │
    └── weather/              # Weather feature
        ├── entity/           # Weather entities
        ├── models/           # Weather models
        ├── providers/        # Weather state management
        ├── repository/       # Weather API repository
        └── widgets/          # Weather widgets
```

### 🔧 Tech Stack

#### Frontend
- **Flutter 3.0+**: Cross-platform mobile framework
- **Dart**: Programming language
- **Material Design 3**: Modern UI components

#### State Management
- **Riverpod 2.4+**: Reactive state management
- **Riverpod Annotation**: Code generation for providers
- **Riverpod Generator**: Build-time code generation

#### Backend & Services
- **Firebase Authentication**: User authentication
- **Cloud Firestore**: NoSQL database
- **Firebase Storage**: File storage (if applicable)

#### Navigation
- **GoRouter**: Declarative routing solution
- **Deep Linking**: Support for deep links

#### Localization
- **flutter_localizations**: Internationalization support
- **intl**: Date/number formatting
- **ARB files**: Translation management

#### Additional Packages
- **google_sign_in**: Google authentication
- **shared_preferences**: Local data persistence
- **flutter_dotenv**: Environment variables
- **equatable**: Value equality

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / Xcode (for mobile development)
- Firebase account
- Google Cloud account (for API keys)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/triptide.git
   cd triptide
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
    - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
    - Add Android and iOS apps to your Firebase project
    - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
    - Place them in the appropriate directories:
        - Android: `android/app/google-services.json`
        - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Configure environment variables**

   Create a `.env` file in the project root:
   ```env
   GEMINI_API_KEY=your_gemini_api_key_here
   WEATHER_API_KEY=your_weather_api_key_here
   ```

5. **Generate code**
   ```bash
   # Generate Riverpod providers
   flutter pub run build_runner build --delete-conflicting-outputs
   
   # Generate localization files
   flutter gen-l10n
   ```

6. **Run the app**
   ```bash
   # For development
   flutter run
   
   # For release
   flutter run --release
   ```

---

## 🔐 Firebase Configuration

### Firestore Collections

```
users/
  └── {userId}
      ├── uid: String
      ├── email: String
      ├── name: String
      ├── profilePic: String (optional)
      ├── phone: String (optional)
      └── isAuthenticated: Boolean

trips/
  └── {tripId}
      ├── userId: String
      ├── destination: String
      ├── startDate: Timestamp
      ├── endDate: Timestamp
      ├── budget: String
      ├── tripType: String
      ├── status: String (planned/visited)
      ├── isFavorite: Boolean
      ├── dailyPlan: Array
      ├── accommodationSuggestions: Array
      ├── transportationDetails: Map
      └── createdAt: Timestamp
```

### Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users collection
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Trips collection
    match /trips/{tripId} {
      allow read: if request.auth != null && resource.data.userId == request.auth.uid;
      allow create: if request.auth != null && request.resource.data.userId == request.auth.uid;
      allow update, delete: if request.auth != null && resource.data.userId == request.auth.uid;
    }
  }
}
```

---

## 🌐 Localization

TripTide supports multiple languages out of the box:

- 🇬🇧 **English** (en)
- 🇮🇳 **Hindi** (hi)

### Adding a New Language

1. Create a new ARB file in `lib/l10n/`:
   ```
   lib/l10n/app_[language_code].arb
   ```

2. Add translations following the English template

3. Add the locale to `main.dart`:
   ```dart
   supportedLocales: const [
     Locale('en'),
     Locale('hi'),
     Locale('es'), // Your new language
   ],
   ```

4. Regenerate localization files:
   ```bash
   flutter gen-l10n
   ```

---

## 🎨 Theming

TripTide includes a beautiful, modern theme system with light and dark mode support.

### Color Scheme

**Light Mode:**
- Primary: Indigo (#6366F1)
- Secondary: Purple (#8B5CF6)
- Background: Light Blue-Gray (#F8F9FD)
- Surface: White

**Dark Mode:**
- Primary: Light Indigo (#818CF8)
- Secondary: Light Purple (#A78BFA)
- Background: Dark Slate (#0F172A)
- Surface: Slate (#1E293B)

### Custom Themes

Modify themes in `lib/core/theme/app_theme.dart`:
```dart
static ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFF6366F1),
  // ... customize colors
);
```

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

---

## 📦 Building for Production

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

---

[//]: # ()
[//]: # (## 🤝 Contributing)

[//]: # ()
[//]: # (Contributions are welcome! Please follow these steps:)

[//]: # ()
[//]: # (1. Fork the repository)

[//]: # (2. Create a feature branch &#40;`git checkout -b feature/amazing-feature`&#41;)

[//]: # (3. Commit your changes &#40;`git commit -m 'Add amazing feature'`&#41;)

[//]: # (4. Push to the branch &#40;`git push origin feature/amazing-feature`&#41;)

[//]: # (5. Open a Pull Request)

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Write comments for complex logic
- Maintain consistent formatting (use `flutter format`)

---

## 📝 Code Generation Commands

```bash
# Generate Riverpod providers
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generate on file changes)
flutter pub run build_runner watch --delete-conflicting-outputs

# Generate localization files
flutter gen-l10n

# Clean generated files
flutter pub run build_runner clean
```

---

## 🐛 Known Issues

- None at the moment

Report issues at: [GitHub Issues](https://github.com/yourusername/triptide/issues)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Gemini AI for intelligent trip planning
- OpenWeather for weather data
- All contributors who helped shape this project

---

## 📧 Contact

- **Email**: ayushs9468@gmail.com
- **Twitter**: [@netfrexk](https://x.com/netfrexk)
- **LinkedIn**: [Ayush Sharma](https://www.linkedin.com/in/ayush-sharma-a716b5252/)

---

## ⭐ Show Your Support

Give a ⭐️ if this project helped you!

---

<div align="center">

Made with ❤️ and Flutter

**[⬆ Back to Top](#-triptide---ai-powered-travel-planner)**

</div>
