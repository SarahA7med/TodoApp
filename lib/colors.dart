import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE1E4E7),
  100: Color(0xFFB3BCC3),
  200: Color(0xFF818F9B),
  300: Color(0xFF4F6272),
  400: Color(0xFF294054),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF031A30),
  700: Color(0xFF021629),
  800: Color(0xFF021222),
  900: Color(0xFF010A16),
});
const int _primaryPrimaryValue = 0xFF031E36;

const MaterialColor secondary = MaterialColor(_secondaryPrimaryValue, <int, Color>{
  50: Color(0xFFE8E3E6),
  100: Color(0xFFC5BABF),
  200: Color(0xFF9F8C95),
  300: Color(0xFF785D6B),
  400: Color(0xFF5B3B4B),
  500: Color(_secondaryPrimaryValue),
  600: Color(0xFF381526),
  700: Color(0xFF301120),
  800: Color(0xFF280E1A),
  900: Color(0xFF1B0810),
});
const int _secondaryPrimaryValue = 0xFF3E182B;

const MaterialColor secondaryAccent = MaterialColor(_secondaryAccentValue, <int, Color>{
  100: Color(0xFFFF5B9A),
  200: Color(_secondaryAccentValue),
  400: Color(0xFFF4005E),
  700: Color(0xFFDA0054),
});
const int _secondaryAccentValue = 0xFFFF287B;


const MaterialColor third = MaterialColor(_thirdPrimaryValue, <int, Color>{
  50: Color(0xFFF0E2E9),
  100: Color(0xFFD8B7C8),
  200: Color(0xFFBF87A3),
  300: Color(0xFFA5577E),
  400: Color(0xFF913362),
  500: Color(_thirdPrimaryValue),
  600: Color(0xFF760D3F),
  700: Color(0xFF6B0B37),
  800: Color(0xFF61082F),
  900: Color(0xFF4E0420),
});
const int _thirdPrimaryValue = 0xFF7E0F46;

const MaterialColor thirdAccent = MaterialColor(_thirdAccentValue, <int, Color>{
  100: Color(0xFFFF81A8),
  200: Color(_thirdAccentValue),
  400: Color(0xFFFF1B61),
  700: Color(0xFFFF024F),
});
const int _thirdAccentValue = 0xFFFF4E84;