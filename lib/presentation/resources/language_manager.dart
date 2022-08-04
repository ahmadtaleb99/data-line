

import 'package:flutter/material.dart';

const String english = 'en';
const String arabic = 'ar';

const Locale englishLocale = Locale("en", "US");
const Locale arabicLocale =  Locale("ar", "SA");

enum LanguageType { ENGLISH, ARABIC }

extension xLanguageType on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return english;
      case LanguageType.ARABIC:
        return arabic;
    }
  }
}
