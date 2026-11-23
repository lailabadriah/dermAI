# Firebase setup for DermAI

This app is ready for Firebase integration, but the Firebase project itself still needs to be configured in the mobile project.

## 1. Create a Firebase project

1. Open Firebase Console.
2. Create a new project named DermAI.
3. Add Android and iOS apps.
4. Download the generated configuration files and place them in the correct platform folders.

## 2. Enable authentication

Go to Firebase Console > Authentication > Sign-in method and enable:
- Email/Password

## 3. Enable Firestore

Go to Firestore Database and create the database in production or test mode.

Recommended collections:
- users
- skinAnalyses
- routineLogs
- consultations

## 4. Configure the Flutter app

For Android:
- put google-services.json under android/app/

For iOS:
- put GoogleService-Info.plist in ios/Runner/

## 5. Final app behavior

This project currently uses safe fallbacks when Firebase is not configured yet, so the app still works in local development while the backend is being connected.

When Firebase is enabled, the app can store:
- user profiles
- skin analysis summaries
- progress history
- routine completion data
