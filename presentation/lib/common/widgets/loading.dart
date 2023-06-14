import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.size = 36,
    this.margin,
  });

  final double size;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: margin,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
