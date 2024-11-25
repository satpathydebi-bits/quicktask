# QuickTask App Documentation

## Introduction
QuickTask is a task management application built using Flutter, integrated with the Parse Server for backend services. It provides functionalities for managing tasks, user authentication, and local data storage using databases like sembast and idb_shim.

## Technologies Used
- **Flutter**: For building the mobile app
- **Parse Server SDK**: For connecting to the Parse Server for backend operations
- **Sembast**: For local storage of tasks
- **idb_shim**: For IndexedDB compatibility
- **Provider**: For state management
- **intl**: For date formatting
- **cupertino_icons**: For iOS-style icons

## App Overview
QuickTask helps users create, view, and manage tasks with both offline and online modes:
- User Authentication through Parse Server
- Task Management with local and cloud storage
- Offline support using local databases

## Features
- Login Screen
- Task List Display
- Task Creation
- Offline Task Management

## App Structure

### 1. main.dart
Entry point of the Flutter app:
- Initializes Flutter
- Connects to Parse Server
- Sets up app configuration

### 2. parse_config.dart
Initializes Parse Server connection:
```dart
Future<void> initializeParse() async {
  const String applicationId = 'rLbOvlsgTAlUZC6iS55ZNineq46ffoNTGVCj1dxa';
  const String clientKey = 'HbBK3btYBO5ewDTXKKaKeNLfKT4pctXLFjXOObzF';
  const String serverUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(applicationId, serverUrl, clientKey: clientKey, autoSendSessionId: true);
}
```

## Installation

### Clone Repository
```bash
git clone https://github.com/your-username/quicktask.git
cd quicktask
```

### Setup Dependencies
```bash
flutter pub get
flutter run
```

## Dependencies (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  parse_server_sdk_flutter: ^8.0.0
  provider: 6.1.2
  intl: ^0.19.0
  sembast: ^3.2.0
```

## App Workflow
1. App Initialization
2. User Login
3. Task Management
4. Offline/Online Synchronization

## Error Handling
```dart
try {
  // Operation logic
} catch (e) {
  print('Error: $e');
}
```

## Contributing
Fork the repository: **https://github.com/satpathydebi-bits/quicktask**

## Conclusion
QuickTask leverages Flutter, Parse Server, and local databases to provide a robust task management solution with offline capabilities.
