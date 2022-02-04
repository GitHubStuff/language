import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'language_hive.dart';

class Language {
  static Future<void> setup() async => await _LocaleHive.setup();
  static _LocaleCubit get cubit => _LocaleCubit._cubit;

  static Locale get locale => _LocaleHive._get();
  static set locale(Locale newLocale) {
    _LocaleHive._save(locale: newLocale);
    _LocaleCubit._cubit.setLocale(newLocale);
  }

  static const List<Locale> supportedLocales = [
    const Locale('de'), // German, no country code
    const Locale('en'), // English, no country code
    const Locale('es'), // Spanish, no country code
    const Locale('ko'), // Korean, no country code
  ];
}
