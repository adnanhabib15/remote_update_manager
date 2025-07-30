

# remote_update_manager

A Flutter package to handle app updates easily using Firebase Remote Config.

## 📦 Features

A Flutter package to handle app updates easily.
It checks the current app version and compares it with the version info from remote config or server:

If the current version is lower than the required version, the user must update the app (no skip option).

If the available version is higher than the current version, the update is optional — the user can choose to either update or skip.

When the user taps the "Update" button, the app automatically redirects them to the App Store or Play Store.


## 🖥️ Platform Support

| Platform | Supported |
|----------|-----------|
| Android  | ✅        |
| iOS      | ✅        |
| Web      | ✅        |
| Windows  | ✅        |
| macOS    | ✅        |
| Linux    | ✅        |



## 🧰 Requirements

Flutter SDK: ≥ 3.32.6

Dart SDK: ≥ 3.8.1


## 🚀 Getting started

1. Create a Firebase Project

     Go to Firebase Console and create a new project.

2. Register Your App

     Register your Android and/or iOS app with the Firebase project.

3. Add Configuration Files

     Download and place the following config files in your Flutter project:

       google-services.json in android/app/

       GoogleService-Info.plist in ios/Runner/

4. Initialize Firebase

In your main.dart, ensure Firebase is initialized

       import 'package:firebase_core/firebase_core.dart';

       void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await Firebase.initializeApp();
       runApp(MyApp());}

5. Enable Remote Config in Firebase Console

     Navigate to Remote Config in the Firebase console.

     Create and publish parameters like:

       latest_version

       minimum_required_version

       optional (bool)

       required (bool)


## 🧩 Usage

 ➕ Add to pubspec.yaml:
   
       dependencies:

       firebase_core: ^3.13.1
       flutter_app_info: ^3.0.3  
       firebase_remote_config: ^5.4.4


 📦 Import and initialize:
 
       import 'package:firebase_remote_package/firebase_remote_package.dart';

       final config = FirebaseRemoteConfiguration(
       androidAppId: 'com.example.myapp',// ✅ Android app  Play Store URL
       iosAppId: '1234567890',        // ✅ iOS App Store ID (numeric from App Store URL));
