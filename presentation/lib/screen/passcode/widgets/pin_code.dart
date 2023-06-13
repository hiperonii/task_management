import 'package:flutter/material.dart';

class PinCode extends StatelessWidget {
  const PinCode({
    Key? key,
    this.isActive = false,
    this.pinSize,
  }) : super(key: key);

  final Size? pinSize;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final size = pinSize ?? const Size.fromRadius(12);
    return ClipOval(
      child: Container(
        width: size.width,
        height: size.height,
        color: isActive ? Colors.grey : Colors.grey.withOpacity(0.2),
      ),
    );
  }
}
