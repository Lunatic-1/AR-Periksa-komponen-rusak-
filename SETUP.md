# Setup Guide for AR-Periksa-komponen-rusak-

## 1. Prerequisites
- **Flutter SDK** (>= 3.13.1) – install from https://flutter.dev/docs/get-started/install
- **Android SDK** (for Android devices/emulators) – included with Android Studio
- **Xcode** (macOS only, for iOS builds)
- **Chrome** (for web target)
- **Visual Studio Build Tools** (Windows, for Windows target)
- **Git** – to clone the repository

## 2. Clone the Repository
```bash
git clone <URL-TO-YOUR-REPOSITORY>
cd AR-Periksa-komponen-rusak-
```
Replace `<URL-TO-YOUR-REPOSITORY>` with the actual Git URL.

## 3. Install Project Dependencies
```bash
flutter pub get
```
This will download all Dart/Flutter packages defined in `pubspec.yaml`.

## 4. Verify the Installation
Run the Flutter doctor to make sure everything is set up correctly:
```bash
flutter doctor
```
Fix any issues reported before proceeding.

## 5. Running the Application
You can run the app on any supported platform. Choose the device/target you want and execute the corresponding command:

### Android
```bash
flutter run -d android
```
(Ensure an Android emulator or a physical device is connected.)

### iOS *(macOS only)*
```bash
flutter run -d ios
```
(An iOS simulator or a connected iPhone is required.)

### Web (Chrome)
```bash
flutter run -d chrome
```
The app will launch in a Chrome browser tab.

### Windows
```bash
flutter run -d windows
```
(Visual Studio Build Tools must be installed.)

## 6. Common Issues & Tips
- **Missing platform tools**: Re‑run `flutter doctor --android-licenses` or install Xcode command‑line tools.
- **Asset not found**: Ensure any AR models are placed in `assets/models/` and declared in `pubspec.yaml` under the `assets:` section.
- **Hot reload**: Press `r` in the terminal after the app starts to hot‑reload changes.
- **Running on a physical device**: Enable developer mode on the device and allow USB debugging (Android) or trust the computer (iOS).

## 7. Contributing
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit and push your changes.
4. Open a Pull Request describing what you changed.

---
*This guide is intended for teammates who are new to the project. Feel free to extend it with platform‑specific notes or additional troubleshooting steps.*
