import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rae_localization_package/rae_localization_package.dart';
import 'package:theme_management/theme_management.dart';

class ThemeAndMaterialWidget extends StatelessWidget with ThemeMixin {
  @override
  Widget build(BuildContext context) => rebuildTreeOnThemeOrCubit<RAELanguageState>(
        bodyWidget: _materialAppBloc,
        cubit: RAELanguage.cubit,
      );

  /// Widget wrapper to enclose switching dark/light mode themes of the MaterialApp
  Widget _materialAppBloc(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        locale: RAELanguage.locale,
        theme: ThemeManagement.lightTheme,
        darkTheme: ThemeManagement.darkTheme,
        themeMode: ThemeManagement.themeMode,
        initialRoute: '/',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('de'), // German, no country code
          const Locale('en'), // English, no country code
          const Locale('es'), // Spanish, no country code
          const Locale('ko'), // Korean, no country code
        ],
      ).modular();
}
