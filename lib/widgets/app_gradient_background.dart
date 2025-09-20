import 'package:flutter/material.dart';

class AppGradientBackground extends StatelessWidget {
  final Widget child;
  
  const AppGradientBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF667eea),
            Color(0xFFf093fb),
          ],
        ),
      ),
      child: child,
    );
  }
}