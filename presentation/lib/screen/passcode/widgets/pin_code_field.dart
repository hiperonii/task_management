import 'package:flutter/material.dart';
import 'package:presentation/screen/passcode/widgets/pin_code.dart';

class PinCodeField extends StatefulWidget {
  const PinCodeField(
    this.code, {
    Key? key,
    this.length = 6,
    this.pinSize,
  }) : super(key: key);

  final int length;
  final Size? pinSize;
  final String code;

  @override
  State<PinCodeField> createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) => _buildPin(index)),
    );
  }

  Widget _buildPin(int index) {
    final double leftPadding = index == 0 ? 0 : 20;
    final active = widget.code.isNotEmpty ? widget.code.length > index : false;
    return Container(
      padding: EdgeInsets.only(left: leftPadding),
      child: PinCode(pinSize: widget.pinSize, isActive: active),
    );
  }
}
