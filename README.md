## 📖  XKCD COMIC APP 
- A simple comic reading app using REST API with Flutter.

## 🔍 App Overview 
- **App Architecture:** MVC *(Model,View,Controller)*

  <img src="https://raw.githubusercontent.com/Adnanbd/xkcd-comic-app-flutter/main/screentshots/Screenshot%202022-06-16%20at%201.25.08%20PM.png" width =400 > 

- **Coding Style:**  `flutter_lints: ^2.0.0`
- **Flutter environment:** `sdk: '>=2.18.0-170.0.dev <3.0.0'`

## 🌈 Features 

- **Browse through the comics**
- **See the comic details, including its description**
- **Search for comics by the comic number as well as text**
- **Get the comic explanation**
- **Favorite the comics, which would be available offline too**
- **Send comics to others**
- <strike> Get notifications when a new comic is published</strike>
- <strike> Support multiple form factors</strike>


## 📱 Screenshots 


| Home Screen  | Searched Screen |
| ------------- | ------------- |
| <img src="https://raw.githubusercontent.com/Adnanbd/xkcd-comic-app-flutter/main/screentshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-06-16%20at%2011.39.39.png" width =300 > | <img src="https://raw.githubusercontent.com/Adnanbd/xkcd-comic-app-flutter/main/screentshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202022-06-16%20at%2011.41.18.png" width =300 >  |

## 📲 Views 
- ### **Home Screen :**

  - Home screen manages main three sceens of the app:

    - Browse Comic Screen.
    - Saved Comic Screen.
    - Searched Comic Screen.

- ### **Explanation Screen :**

  - Showing the explanation page of a particular comic using WebView.

- ### **Widgets :**

  - There are few widgets to help to build the UI:

    - Custom Card Comic. (To show a single comic details)
    - Custom Image View. (This widget helps to display comic image with interactive functionality)
    - And More ...

## 📦 Packages 
- Here are some packages used to improve the app:
 
  | Functionality  | Package |
  | ------------- | ------------- |
  | Handles state management of the app | [![](https://img.shields.io/badge/provider-^6.0.3%20-blue?style=for-the-badge&logo=flutter)](https://pub.dev/packages/provider) |
  | Handles all network request | [![](https://img.shields.io/badge/http-^0.13.4%20-blue?style=for-the-badge&logo=flutter)](https://pub.dev/packages/http) |
  | Provides Google Fonts  | [![](https://img.shields.io/badge/google__fonts-^3.0.1%20-blue?style=for-the-badge&logo=flutter)](https://pub.dev/packages/google_fonts) |
  | Help to create beautiful animated search bar  | [![](https://img.shields.io/badge/anim__search__bar-^2.0.2%20-blue?style=for-the-badge&logo=flutter)](https://pub.dev/packages/anim_search_bar) |
  | Helps to render WebView  | [![](https://img.shields.io/badge/webview__flutter-^3.0.4%20-blue?style=for-the-badge&logo=flutter)](https://pub.dev/packages/webview_flutter) |
  | Helps to share any link/text through social media apps  | [![](https://img.shields.io/badge/share__plus-^4.0.7%20-blue?style=for-the-badge&logo=flutter)](https://pub.dev/packages/share_plus) |
  | Renders dynamic progress bars  | [![](https://img.shields.io/badge/flutter__spinkit-^5.1.0%20-blue?style=for-the-badge&logo=flutter)](https://pub.dev/packages/flutter_spinkit) |
  | Cached Network Images for later use  | [![](https://img.shields.io/badge/cached__network__image-^3.2.1%20-blue?style=for-the-badge&logo=flutter)](https://pub.dev/packages/cached_network_image) |
  | Helps to store data locally  | [![](https://img.shields.io/badge/shared__preferences-^2.0.15%20-blue?style=for-the-badge&logo=flutter)](https://pub.dev/packages/shared_preferences) |

  



