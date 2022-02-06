import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:language_package/language_package.dart';
import 'package:theme_management/theme_management.dart';
import 'package:widget_tree_package/widet_tree_package.dart';

class ThemeAndMaterialWidget extends StatelessWidget with WidgetTreeMixin {
  @override
  Widget build(BuildContext context) => rebuildTreeOnThemeOrLanguageChange(body: _materialAppBloc);

  /// Widget wrapper to enclose switching dark/light mode themes of the MaterialApp
  Widget _materialAppBloc(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        locale: Language.locale,
        theme: ThemeManagement.lightTheme,
        darkTheme: ThemeManagement.darkTheme,
        themeMode: ThemeManagement.themeMode,
        initialRoute: '/',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Language.supportedLocales,
      ).modular();
}
