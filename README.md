# Flutter Notes App with Firebase Realtime Database

This Flutter application allows you to perform CRUD (Create, Read, Update, Delete) operations on notes using Firebase Realtime Database.

## Getting Started

Follow the steps below to set up the project and connect it to Firebase Realtime Database.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli#install_the_firebase_cli)
- A Firebase project

## Firebase Setup for Flutter Application

### 1. Set Up Firebase

#### 1.1. Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Click on **Add Project** and follow the setup instructions.
3. Once your project is created, navigate to the **Realtime Database** section and click **Create Database**.
4. Choose a location for your database and select **Start in test mode** to allow all reads and writes (for testing purposes).

#### 1.2. Add Firebase to Your Flutter App

1. Install the FlutterFire CLI globally:
   ```bash
   dart pub global activate flutterfire_cli
