
import 'package:flutter/material.dart';
import 'package:new_store/theme/collections/colorCollection.dart';
import 'package:new_store/theme/themes/themeText.dart';

final themeData = ThemeData(
  buttonTheme: const ButtonThemeData(
    disabledColor: ColorCollection.white
  ),
  chipTheme:  ChipThemeData(
    labelStyle: textTheme.bodyMedium,
    backgroundColor: ColorCollection.background,
    selectedColor: ColorCollection.input,

  ),
  appBarTheme: const AppBarTheme(backgroundColor: ColorCollection.background,),
  scaffoldBackgroundColor: ColorCollection.background,
    useMaterial3: true,
    textTheme: textTheme);