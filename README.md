![alt text](https://github.com/SahanMonaara/tweety/blob/main/screenshots/tweety.png?raw=true)
# Welcome to Tweety!
**Getting Started**

This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
## Versions

These are the version for development that has been used.

|                |Version                                 |
|----------------|----------------------------------------|
|Flutter.        |**2.2.3**                     |
|Dart            |**2.13.4**                    |

## Technologies & Language

Flutter, Firebase and Dart

## How to deploy

In the terminal run these codes to run the application on your connected device.

### `flutter clean`

### `flutter pub get`

### `flutter run`


To build a debug release please run the below code on the terminal

### `flutter build apk`

## How to delete a Tweet

User can delete a tweet by long pressing on a single tweet.

## Folder Structure
    ├── ...
    ├── configurations              
    │   └── app_shared_data.dart               # Shared preference to cache data
    │   └── google_sign_in_provider.dart       # Firebase Authentication provider
    └── screens                 
    │   └── common_components               
    |     └── backgrounds          
    |	  |      └── common_background_component.dart        # Custom background component
    |	  |      └──common_background_lower_component.dart   # Custom lower component
    |	  |      └── common_background_upper_component.dart  # Custom upper component
    |     └── buttons              
    |     |   └── common_elevated_button.dart               # Custom upper component
    |     └── user_interfaces                               # All User Interfaces are here 
    |         └── home           
    |         |     └── home_screen.dart                    # Home Screen
    |         └── login_flow            
    |         |     └── login_screen.dart                   # Login Screen
    |         └── base_view.dart                            # Base view of the application
    └── utils                                               # Application utility folder 
    │     ├── app_colors.dart                               # Colors are defined here
    │     ├── app_constants.dart                            # Constants are defined here 
    │     ├── app_images.dart                               # Common Image paths
    │     ├── app_text_styles.dart                          # Common text styling 
    │     ├── injection_container.dart                      # Dependency injection
    │     ├── navigation_routes.dart                        # Routes are defined here
    │     └── string_utils.dart                             # String utils defined here              
    └── app.dart                                            # Routes are defined here
    └── main.dart                                           # Entry point of the application



## Screenshots
| <img src="https://github.com/SahanMonaara/tweety/blob/main/screenshots/Screenshot%202021-07-22%20at%2009.28.26.png"  width="200" height="400"> |<img src="https://github.com/SahanMonaara/tweety/blob/main/screenshots/Screenshot%202021-07-22%20at%2009.28.48.png"  width="200" height="400"> |
| <img src="https://github.com/SahanMonaara/tweety/blob/main/screenshots/Screenshot%202021-07-22%20at%2009.30.05.png"  width="200" height="400">|

<img src="https://github.com/SahanMonaara/tweety/blob/main/screenshots/Screenshot%202021-07-22%20at%2009.29.08.png"  width="200" height="400">|
| <img src="https://github.com/SahanMonaara/tweety/blob/main/screenshots/Screenshot%202021-07-22%20at%2009.29.19.png"  width="200" height="400"> | <img src="https://github.com/SahanMonaara/tweety/blob/main/screenshots/Screenshot%202021-07-22%20at%2009.29.43.png"  width="200" height="400">|
