import 'package:flutter/material.dart';

class PinCode extends StatelessWidget {
  const PinCode({
    Key? key,
    this.isActive = false,
    this.isError = false,
    this.pinSize = const Size.fromRadius(12),
  }) : super(key: key);

  final Size pinSize;
  final bool isActive;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: pinSize.width,
        height: pinSize.height,
        color: _getColor(),
      ),
    );
  }

  Color _getColor() {
    if (isError) {
      return Colors.pinkAccent.shade100;
    }

    return isActive ? Colors.purple : Colors.grey.withOpacity(0.1);
  }
}
