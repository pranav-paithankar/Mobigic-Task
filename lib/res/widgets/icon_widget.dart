import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final Color color;
  final double size;

  const IconWidget({Key? key, required this.color, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search_rounded,
      color: color,
      size: size,
    );
  }
}
