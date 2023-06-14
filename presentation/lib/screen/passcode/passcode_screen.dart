import 'package:flutter/material.dart';
import 'package:presentation/screen/passcode/passcode_view_model.dart';
import 'package:presentation/screen/passcode/widgets/pin_code_field.dart';
import 'package:presentation/screen/passcode/widgets/virtual_keyboard.dart';
import 'package:presentation/service/navigation/navigation_service.dart';
import 'package:presentation/service/passcode/passcode_service.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({Key? key}) : super(key: key);

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  late final PasscodeViewModel _viewModel = PasscodeViewModel(PasscodeService(), NavigationService());

  @override
  void initState() {
    super.initState();
    PasscodeService().stop();
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPinCodeField(),
          const SizedBox(height: 60),
          VirtualKeyboard(key: const ValueKey('Keyboard'), onTap: _viewModel.onKeyTap),
        ],
      ),
    );
  }

  Widget _buildPinCodeField() {
    return StreamBuilder<String>(
        stream: _viewModel.passcodeSubject,
        builder: (_, snapshot) {
          final isError = snapshot.hasError;
          return Column(
            children: [
              PinCodeField(snapshot.data ?? '', isError: isError),
              const SizedBox(height: 12),
              if (isError) Text('Incorrect passcode', style: TextStyle(color: Colors.pink.withOpacity(0.5))),
            ],
          );
        });
  }
}
