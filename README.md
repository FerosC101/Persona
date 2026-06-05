# persona

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Firebase Login Setup

This project now includes Firebase Authentication support for email/password login.

### 1. Install Firebase packages

Run:
```bash
flutter pub get
```

### 2. Configure Android

1. Create a Firebase project at https://console.firebase.google.com
2. Register an Android app with the package name `com.example.persona`
3. Download `google-services.json`
4. Place it in `android/app/`
5. Rebuild the app with `flutter run`

### 3. Configure Web

1. Open your Firebase project in the console.
2. Register a new Web app and give it a nickname.
3. Copy the Firebase config values from the console.
4. Run the FlutterFire CLI from the project root:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
5. This generates `lib/firebase_options.dart`.
6. Re-run:
   ```bash
   flutter run -d chrome
   ```

### 4. Configure iOS

1. Register an iOS app in the same Firebase project
2. Download `GoogleService-Info.plist`
3. Add it to `ios/Runner/`
4. Run `pod install` inside `ios/`

### 5. What was added

- `firebase_core` and `firebase_auth` dependencies
- `lib/services/firebase_auth_service.dart`
- Firebase app initialization in `lib/main.dart`
- Login screen now uses Firebase Authentication
- Android Gradle config updated for Firebase services

### 5. How it works

- Existing login flow uses Firebase email/password sign-in
- The registration flow creates a Firebase user account when "Complete Registration" is tapped
- On successful auth, the app navigates to the home page

### 6. Notes

- If you want web support, run the FlutterFire CLI to generate `firebase_options.dart`
- If you change the Android application ID, use the same bundle ID in Firebase
