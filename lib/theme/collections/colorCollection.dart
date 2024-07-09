import 'dart:ui';

import 'package:flutter/material.dart';

class ColorCollection {
  static const primary = Color(0xFF1328DE);
  static const onPrimary = Color(0xFF53A2FF);
  static const background = Color(0xFFFAFAFD);
  static const input = Color(0xFFF5F5F5);
  static const bottomBar = Color(0xFFD9D9D9);
  static const text = Color(0xFF63625D);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const shimerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
