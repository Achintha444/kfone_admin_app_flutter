import 'package:flutter/material.dart';

class ResizableImage extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit fit;

  const ResizableImage({
    super.key,
    this.height,
    this.width,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/logo.png'),
          fit: fit,
        ),
      ),
    );
  }
}

