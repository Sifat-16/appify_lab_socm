import 'package:flutter/material.dart';

Animatable<Offset> rtlTweens(){
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;
  return Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
}

Animatable<Offset> utbTweens(){
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  const curve = Curves.ease;
  return Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
}