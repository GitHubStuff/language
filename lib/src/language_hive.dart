part of 'language.dart';

@immutable
class _LocaleStateAbstract {}

class _LocaleChanged extends _LocaleStateAbstract {
  final Locale newLocale;
  _LocaleChanged(this.newLocale);
}

class _LocaleCubit extends Cubit<_LocaleStateAbstract> {
  static final _LocaleCubit _singleton = _LocaleCubit._internal();
  factory _LocaleCubit() => _singleton;
  _LocaleCubit._internal() : super(_LocaleStateAbstract());
  static _LocaleCubit get _cubit => _singleton;

  void setLocale<T>(Locale locale) => emit(_LocaleChanged(locale));
}

///
bool _isLocaleHiveSetup = false;
Locale _hiveLocale = Locale('en');

class _LocaleHive {
  static const _boxName = 'com.LanguageHiveManager.Language.hive.locale';
  static Box? _box;

  static Future<void> setup() async {
    if (_isLocaleHiveSetup) return;
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox<String>(_boxName);
    } on NullThrownError {
    } on MissingPluginException {
    } catch (e) {
      throw FlutterError(e.toString());
    }
    _isLocaleHiveSetup = true;
    _hiveLocale = _get();
  }

  static Locale _save({required Locale locale}) {
    final String languageCode = locale.languageCode;
    if (!_isLocaleHiveSetup) {
      debugPrint('📡 Hive-setup not called, temp setting $languageCode');
      _hiveLocale = locale;
      return _hiveLocale;
    }
    _box?.put(_boxName, languageCode);
    return Locale(languageCode);
  }

  static Locale _get() {
    if (!_isLocaleHiveSetup) {
      debugPrint('📡 Hive-setup not called: using ${_hiveLocale.languageCode}');
      return _hiveLocale;
    }
    String storedValue = _box?.get(_boxName, defaultValue: 'en'); // 'en' - english
    return Locale(storedValue);
  }
}
