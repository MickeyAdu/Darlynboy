import 'package:flutter/material.dart';

class BoxImageDecoration extends StatelessWidget {
  const BoxImageDecoration({required this.imageUrl, super.key});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(imageUrl))),
      ),
      shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.grey.withOpacity(0.1),
          ]).createShader(bounds),
    );
  }
}
