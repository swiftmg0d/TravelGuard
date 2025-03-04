# TravelGuard - Your Travel Companion

<video controls src="https://raw.githubusercontent.com/swiftmg0d/TravelGuard/master/assets/video/preview.mp4" autoplay loop muted></video>

## Table of Contents

- [Description](#description)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Key Features](#key-features)

## Description

TravelGuard is a mobile application designed to allow users to place markers on a map and receive notifications when they are close to those markers. Users can log into the app, set markers, and define the distance at which they want to be alerted. The app offers different types of notifications, such as push notifications, alarms, or vibrations.

At the start of a journey, users will need to take a photo of their starting location. When they approach a marker, the app will send a notification or begin vibrating. Upon receiving the notification, users can upload a picture of their final destination and click the "Finish" button. The app will then display statistics about the journey, including duration, distance, and other relevant details. Users will have the option to save their trips to a history section, where they can view trip details.

The app is especially useful when traveling and wanting to visit a specific location, but also needing reminders not to miss it. For example, you can set a reminder to visit an object while also ensuring that you don't miss it due to other travel distractions.

## Tech Stack

- **Frontend**: Flutter
- **Backend**: Firebase

## Installation

Follow these steps to set up the project locally:

### 1. Clone the repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/swiftmg0d/TravelGuard.git
```

### 2. Navigate to the project directory

Change into the project directory:

```bash
cd TravelGuard
```

### 3. Set up Flutter for the mobile app

Ensure that you have Flutter installed on your machine. If you don't have it yet, you can follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

Once Flutter is installed, navigate to the project directory and run the following commands:

```bash
flutter pub get      # Install dependencies
flutter run          # Run the app
```

### 4. Set up Firebase

Since the app uses Firebase for authentication and data storage, you have two options for setting up Firebase:

**Option 1: Set Up a New Firebase Project**

- Create a Firebase project on the [Firebase Console](https://console.firebase.google.com/).
- Follow the setup instructions to configure your app with Firebase for both iOS and Android.
- Enable Firebase Authentication and Firestore in your Firebase project.

**Option 2: Use the Default Firebase Setup**

- If Firebase has already been initialized in the project, simply use the default setup.

### 5. Run the app

After configuring Firebase, you can run the app on your device/emulator:

```bash
flutter run
```

### 6. Testing the App

Once everything is set up, the app should run locally on your mobile device/emulator. You’ll be able to:

- Log in via Firebase Authentication.
- Place markers on the map.
- Receive notifications when near those markers.
- Capture photos of your journey.
- View trip statistics.

### Key Features:

- **Geofencing**: Virtual boundaries around markers to trigger notifications.
- **GPS Integration**: Accurate location tracking for users using `geolocator` and `location`.
- **Push Notifications**: Alerts when the user is near a marker using `flutter_local_notifications`.
- **Vibration Alerts**: Customizable alerts via vibrations.
- **Map Integration**: Google Maps or OpenStreetMap integration using `flutter_map` and `flutter_osm_plugin` to display markers and user location.
- **User Interface**: Simple and intuitive interface for placing markers and setting distances.
- **Camera Integration**: Capturing images of the start and final positions using `camera` and storing them via `firebase_storage`.
- **Statistics**: Displays trip stats like duration, speed, and distance.
- **History**: Option to save and review trip details.
- **Animations**: Enhance UX with `lottie` and `loading_animation_widget`.
- **Authentication**: Firebase Authentication for login and registration.
- **Location Permissions**: Managed via `permission_handler` for requesting and accessing location data.
