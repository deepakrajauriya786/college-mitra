import 'package:flutter/material.dart';

enum SlideDirection {
  left,
  right,
  top,
  bottom,
}

class SlideTransitionPageRoute extends PageRouteBuilder {
  final Widget page;
  final SlideDirection direction;
  final Duration duration;

  SlideTransitionPageRoute({
    required this.page,
    this.direction = SlideDirection.right,
    this.duration = const Duration(milliseconds: 800),
  }) : super(
          transitionDuration: duration,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin;
            switch (direction) {
              case SlideDirection.left:
                begin = const Offset(-1.0, 0.0);
                break;
              case SlideDirection.right:
                begin = const Offset(1.0, 0.0);
                break;
              case SlideDirection.top:
                begin = const Offset(0.0, -1.0);
                break;
              case SlideDirection.bottom:
                begin = const Offset(0.0, 1.0);
                break;
            }
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

void changeScreen(BuildContext context, Widget page,
    {SlideDirection direction = SlideDirection.right}) {
  Navigator.push(
    context,
    SlideTransitionPageRoute(
      page: page,
      direction: direction,
      duration: const Duration(milliseconds: 600),
    ),
  );
}

void replaceScreen(BuildContext context, Widget page,
    {SlideDirection direction = SlideDirection.right}) {
  Navigator.pushReplacement(
    context,
    SlideTransitionPageRoute(
      page: page,
      direction: direction,
      duration: const Duration(milliseconds: 600),
    ),
  );
}

void removePreviousRoutes(BuildContext context, Widget page,
    {SlideDirection direction = SlideDirection.right}) {
  Navigator.pushAndRemoveUntil(
    context,
    SlideTransitionPageRoute(
      page: page,
      direction: direction,
      duration: const Duration(milliseconds: 600),
    ),
    (Route<dynamic> route) => false,
  );
}
