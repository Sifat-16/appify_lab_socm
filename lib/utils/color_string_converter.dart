import 'package:flutter/material.dart';

String colorToString(Color color) {
  return '#${color.value.toRadixString(16)}';
}

Color stringToColor(String value) {
  value = value.replaceFirst('#', '');
  int colorValue = int.parse(value, radix: 16);
  return Color(colorValue);
}