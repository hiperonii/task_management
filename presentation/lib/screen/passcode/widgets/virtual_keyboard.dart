import 'package:flutter/material.dart';
import 'package:presentation/screen/passcode/widgets/key_symbols.dart';

class VirtualKeyboard extends StatefulWidget {
  const VirtualKeyboard({super.key, this.onTap});

  final ValueChanged<KeySymbols>? onTap;

  @override
  State<VirtualKeyboard> createState() => _VirtualKeyboardState();
}

class _VirtualKeyboardState extends State<VirtualKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _buildKey(KeySymbols.one),
          _buildKey(KeySymbols.two),
          _buildKey(KeySymbols.three),
        ]),
        TableRow(children: [
          _buildKey(KeySymbols.four),
          _buildKey(KeySymbols.five),
          _buildKey(KeySymbols.six),
        ]),
        TableRow(children: [
          _buildKey(KeySymbols.seven),
          _buildKey(KeySymbols.eight),
          _buildKey(KeySymbols.nine),
        ]),
        TableRow(children: [
          const SizedBox.shrink(),
          _buildKey(KeySymbols.zero),
          const SizedBox.shrink(),
        ]),
      ],
    );
  }

  Widget _buildKey(KeySymbols key) {
    return InkWell(
      key: ValueKey('$key'),
      onTap: () => widget.onTap?.call(key),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Text(key.value,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.black54,
            )),
      ),
    );
  }
}
