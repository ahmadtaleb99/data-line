import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_manager.dart';

const String keyLanguage = 'keyLanguage';
const String keyIsLoggedIn = 'keyIsLoggedIn';
const String keyOnboardingScreenViewed = 'keyOnboardingScreenViewed';

class AppPreferences {
  final SharedPreferences _prefs;
  AppPreferences(this._prefs);

  bool isRtl() => getLocale() == arabicLocale;

  String getAppLanguage() {
    String? language = _prefs.getString(keyLanguage);

    if (language == null || language.isEmpty) {
      log('returning ${LanguageType.ENGLISH.getValue()}');

      return LanguageType.ENGLISH.getValue();
    }

    log('returning ${language}');
    return language;
  }

  void changeAppLanguage(){
    if(getAppLanguage() ==  LanguageType.ENGLISH.getValue()){
      _prefs.setString(keyLanguage, LanguageType.ARABIC.getValue());
      log('putting arabic');
    }
   else {
      log('putting english');
      _prefs.setString(keyLanguage, LanguageType.ENGLISH.getValue());
    }

  }


  Locale getLocale(){
    String? language = getAppLanguage();

    if (language == null || language.isEmpty) {
      log('getLocale english null or empty');
      return englishLocale;
    }

    if(language == LanguageType.ARABIC.getValue()){
      log('getLocale arabic');
      return arabicLocale;
    }
    log('getLocale english');

    return englishLocale;

  }

  void setLocale(){

  }


  void setOnboardingScreenViewed() => _prefs.setBool(keyOnboardingScreenViewed, true);

  void setIsLoggedIn(bool isLoggedIn ) => _prefs.setBool(keyIsLoggedIn, isLoggedIn);

  bool isLoggedIn() => _prefs.getBool(keyIsLoggedIn) ?? false;

  bool isOnboardingScreenViewed() => _prefs.getBool(keyOnboardingScreenViewed) ?? false;
}
