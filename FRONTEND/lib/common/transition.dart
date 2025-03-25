import 'dart:async';

import 'package:flutter/material.dart';

Route createSlideRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Mulai dari bawah
      const end = Offset.zero; // Akhir di posisi normal
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

void navigateWithDelay(BuildContext context, Widget page, {int seconds = 2}) {
  Timer(Duration(seconds: seconds), () {
    Navigator.of(context).pushAndRemoveUntil(
      createSlideRoute(page),
      (route) => false,
    );
  });
}
