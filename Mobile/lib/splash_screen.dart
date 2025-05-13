import 'package:flutter/material.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '🔮 AI FortuneTeller',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
