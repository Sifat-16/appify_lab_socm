
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage slideTransition(Widget child, Animatable<Offset> tween){
  return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondary, child){
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
  );
}

