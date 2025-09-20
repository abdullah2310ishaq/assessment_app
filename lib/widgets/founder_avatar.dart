import 'package:flutter/material.dart';

class FounderAvatar extends StatelessWidget {
  final String avatar;
  final Color? backgroundColor;
  final double size;

  const FounderAvatar({
    Key? key,
    required this.avatar,
    this.backgroundColor,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: backgroundColor ?? Colors.grey.withOpacity(0.1),
      child: Text(
        avatar,
        style: TextStyle(fontSize: size / 2),
      ),
    );
  }
}