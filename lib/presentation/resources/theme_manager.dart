
import 'package:flutter/material.dart';
import 'package:datalines/presentation/resources/style_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
      toggleableActiveColor: ColorManager.primary,



    // cardview theme

    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4),
    //app bar
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.lightPrimary,
        titleTextStyle:
            getRegularStyle(fontSize: FontSize.s20, color: ColorManager.white)),

    //button  theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.white, fontSize: FontSize.s17),
            primary: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: getRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s17),
      ),

    ),

    // text theme
    textTheme: TextTheme(

        overline: getLightStyle(color: ColorManager.white, fontSize: FontSize.s22),
        headline1: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
        headline2: getRegularStyle(color: ColorManager.darkGrey, fontSize: FontSize.s14),
        subtitle1: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s14),
        subtitle2: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),

        caption: getRegularStyle(color: ColorManager.grey1),
        bodyText1: getRegularStyle(color: ColorManager.grey),
        bodyText2: getRegularStyle(color: ColorManager.primary),
        headline3: getBoldStyle(color: ColorManager.primary)

    ),

    //input decoration
    inputDecorationTheme:   InputDecorationTheme(
        fillColor: ColorManager.grey,
        focusedBorder:OutlineInputBorder(
          borderSide:  BorderSide(color: ColorManager.primary, width: 2.0),
          borderRadius: BorderRadius. circular(25.0),
        ),
        enabledBorder:OutlineInputBorder(
          borderSide:  BorderSide(color: ColorManager.primary, width: 2.0),
          borderRadius: BorderRadius. circular(25.0),
        ),
        errorBorder:OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius. circular(25.0),
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius. circular(25.0),
        ) ,
    )
    ,
    // label style


  );
}
