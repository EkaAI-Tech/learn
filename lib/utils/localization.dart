import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Small helpers around easy_localization used across the app.
///
/// UI strings live in `assets/lang/<code>.json` (en, ar, fr, es) and are
/// read with `'key'.tr()`.
///
/// Learning content (animal names, descriptions, ...) keeps its English
/// source text in the Dart data (see `AppConstants`) and its translations
/// in `ar.json`, `fr.json` and `es.json` under
/// `words.<group>.<English name>` and `descriptions.<group>.<English name>`. The English name stays the
/// identifier (for images, quiz answers, etc.), only the displayed and
/// spoken text changes with the language.
class AppLang {
  AppLang._();

  static const Locale english = Locale('en');
  static const Locale arabic = Locale('ar');
  static const Locale french = Locale('fr');
  static const Locale spanish = Locale('es');

  static const List<Locale> supported = [english, arabic, french, spanish];

  /// Language names as each language writes itself (for the language menu).
  static const Map<String, String> nativeNames = {
    'en': 'English',
    'ar': 'العربية',
    'fr': 'Français',
    'es': 'Español',
  };

  /// Short label shown on the compact language button.
  static const Map<String, String> shortNames = {
    'en': 'EN',
    'ar': 'ع',
    'fr': 'FR',
    'es': 'ES',
  };

  /// Current language code, kept in sync by `MyApp.build`.
  static String code = 'en';

  static bool get isArabic => code == 'ar';

  /// Language used by flutter_tts for the current locale.
  static String get ttsLanguage {
    switch (code) {
      case 'ar':
        return 'ar-SA';
      case 'fr':
        return 'fr-FR';
      case 'es':
        return 'es-ES';
      default:
        return 'en-IN';
    }
  }

  /// Voice for the A-Z section: Arabic has its own alphabet, the other
  /// languages keep the English A-Z cards, so they are read in English.
  static String get alphabetTtsLanguage => isArabic ? 'ar-SA' : 'en-IN';

  /// Changes the app language without leaving the current page.
  static Future<void> setLanguage(BuildContext context, Locale locale) async {
    code = locale.languageCode;
    await context.setLocale(locale);
    // Texts read with 'key'.tr() don't listen to locale changes by
    // themselves, so ask every widget of every open page to rebuild.
    void rebuild(Element element) {
      element.markNeedsBuild();
      element.visitChildren(rebuild);
    }

    WidgetsBinding.instance.rootElement?.visitChildren(rebuild);
  }
}

const _westernDigits = '0123456789';
const _arabicIndicDigits = '٠١٢٣٤٥٦٧٨٩';

/// Shows numbers the way the current language writes them:
/// Western digits (0-9) in English, Arabic-Indic digits (٠-٩) in Arabic.
String localizeDigits(Object? value) {
  final text = '${value ?? ''}';
  if (!AppLang.isArabic) return text;
  final buffer = StringBuffer();
  for (final ch in text.split('')) {
    final i = _westernDigits.indexOf(ch);
    buffer.write(i >= 0 ? _arabicIndicDigits[i] : ch);
  }
  return buffer.toString();
}

String _trOr(String key, String fallback) {
  // English text lives in the Dart data; other languages in <code>.json.
  if (AppLang.code == 'en') return fallback;
  final value = key.tr();
  return value == key ? fallback : value;
}

/// Translates a vocabulary word of a given [group]
/// (animals, birds, body, colors, flowers, fruits, planets, shapes,
/// seasons, occupations). Falls back to the English word.
String tw(String group, String word) => _trOr('words.$group.$word', word);

/// Translates a longer description of an item. Falls back to [english].
String tdesc(String group, String name, String english) =>
    _trOr('descriptions.$group.$name', english);
