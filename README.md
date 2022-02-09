# language_package

Persits the selected language/locale; provides helper for widget-tree rebuild on locale changes; helper in adding languages to the MaterialApp()

## Install

```text
dependencies:
  language_package:
    git:
      url: https://github.com/GitHubStuff/language_package.git
```

***- OR -***

```text
dependencies:
  language_package:
    git:
      url: https://github.com/RAE-Health/language_package.git
```

## Import

```dart
import 'package:language_package/language_package.dart';
```

## Usage

```dart
var v = Language.cubit;    //Accessor to the cubit
var l = Language.locale;   //Returns the current/active locale
Language.locale = Locale('es');  //Set the curretn/active locale and, if setup(), persists the local in HIVE
static const List<Locale> supportedLocales; // Helper to use in MaterialApp() to provide single-truth on supported languages
```

## Final Note

Be kind to each other
