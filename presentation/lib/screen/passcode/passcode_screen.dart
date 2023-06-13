import 'package:flutter/material.dart';
import 'package:presentation/screen/passcode/passcode_view_model.dart';
import 'package:presentation/screen/passcode/widgets/pin_code_field.dart';
import 'package:presentation/screen/passcode/widgets/virtual_keyboard.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({Key? key}) : super(key: key);

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  late final PasscodeViewModel _viewModel = PasscodeViewModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.purple.shade50,
        body: SafeArea(child: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPinCodeField(),
        const SizedBox(height: 60),
        VirtualKeyboard(onTap: _viewModel.onKeyTap),
      ],
    );
  }

  Widget _buildPinCodeField() {
    return StreamBuilder<String>(
        stream: _viewModel.passcodeSubject,
        builder: (_, snapshot) {
          return PinCodeField(snapshot.data ?? '');
        });
  }
}
