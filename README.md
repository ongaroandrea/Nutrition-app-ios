# Nutrition app

This project was developed as part of the “Mobile Application” course at the University of Bologna, Cesena.

The application focuses on promoting user engagement with their physical and emotional wellbeing through intuitive and interactive features, including:
- Tracking recipes, physical results, and diet plans.
- Logging and managing feelings with notifications and manual input.
- Scheduling and viewing appointments with data visualization using detailed graphs.
- Customizing settings, including biometric unlocking and weekly notifications.

The app also adapts to the system language, offering a seamless experience in both Italian and English.

<details>
  <summary>Table of contents</summary>
  <ol>
    <li>
      Overview
    </li>
    <li>
      Features
    </li>
    <li>
      Requirements
    </li>
    <li>Installation</li>
    <li>Build with</li>
    <li>License</li>
  </ol>
</details>

## Overview

Provide a brief introduction to the project:
	•	Purpose
	•	Target audience
	•	Key technologies used

## Features

#### Home Screen
- View recipes, latest physical results, and diet information.

#### Feelings Screen
- Display a list of logged feelings.
- Add feelings manually via a dedicated button or notifications.

#### Appointments Screen
- Schedule appointments and save them directly to the calendar using EventKit.
- View data collected during visits through interactive graphs.

#### Settings Screen
- Create weekly recurring local notifications.
- Edit personal data.
- Enable Biometric Unlock using FaceID or TouchID (if available on the device).
- In the case of sensor error or absence, fallback to unlock via saved credentials.

#### System Behavior
- Automatically adjusts content language (Italian or English) based on the system language setting.
 
## Requirements
- Swift: Version 5.5 or higher
- Xcode: Version 13 or higher
- iOS: Version 13.0 or higher

## Installation

- Clone the repository:
``` bash
git clone https://github.com/ongaroandrea/Nutrition-app-ios.git
```

- Open the project in Xcode:
``` bash
cd  nutrition-app-ios
open Progetto-Mobile.xcodeproj  
```

- Build and run the project:
  - Select the target device or simulator in Xcode.
  - Press Cmd + R to run.

## Tecnologies used

- Swift Charts v3.6.0: For creating interactive and visually appealing graphs.
- GRDB v5.24.0: A powerful SQLite toolkit for Swift.
- SwiftKeychainWrapper v4.0.1: For securely storing sensitive user data.
- Biometric Sensors: FaceID and TouchID integration for authentication.
- EventKit: For managing and saving appointments to the device’s calendar.
- UserNotifications: To create and manage local notifications.
- Swift v5.5: For modern, efficient, and safe app development.
- Localization: Supports multilingual content, dynamically switching between Italian and English.

## License

Distributed under the MIT License. See LICENSE.txt for more details.
