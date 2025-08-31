# Farming Assistant (Flutter + Firebase)
Smart farming app with IoT sensor streaming + on-device AI (TFLite) plant
disease detection.
## Prerequisites
- Flutter 3.22+
- Firebase project
- A TFLite model (e.g., MobileNet/EfficientNet fine-tuned on plant disease
dataset) and `labels.txt`
## Setup
1. Clone or copy files.
2. Run `dart pub get`.
3. Install FlutterFire CLI: `dart pub global activate flutterfire_cli`.
4. Run `flutterfire configure` and select your Firebase project.
- This generates `lib/firebase_options.dart` automatically.
5. Place your model and labels:
- `assets/models/model.tflite`
- `assets/models/labels.txt`
6. Update `pubspec.yaml` assets paths if you use a different location.
7. (Android) Ensure `minSdkVersion 21` and add internet permission.
8. (iOS) Run `pod install` in `ios/` after configuring Firebase.
