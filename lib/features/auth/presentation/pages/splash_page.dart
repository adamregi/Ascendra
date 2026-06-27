import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeIn,
          builder: (context, opacity, child) {
            return Opacity(
              opacity: opacity,
              child: Image.asset(
                'assets/branding/ascendra_logo.png',
                width: 150,
                height: 150,
              ),
            );
          },
        ),
      ),
    );
  }
}
