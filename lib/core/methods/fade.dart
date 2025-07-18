import 'package:flutter/material.dart';

PageRouteBuilder fade<T>({
  required Widget page,
  required String name,
}) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: const Interval(
          0,
          1,
          curve: Curves.linear,
        ),
      ),
      child: child,
    ),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    settings: RouteSettings(name: name),
  );
}
