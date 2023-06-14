import 'package:presentation/screen/passcode/widgets/key_symbols.dart';
import 'package:presentation/service/navigation/navigation_service.dart';
import 'package:presentation/service/navigation/routes.dart';
import 'package:rxdart/rxdart.dart';

class PasscodeViewModel {
  static const _passCodeLength = 6;

  late final BehaviorSubject<String> passcodeSubject = BehaviorSubject.seeded('');

  String get _code => passcodeSubject.value;

  void onKeyTap(KeySymbols key) {
    if (_code.length == _passCodeLength) {
      return;
    }

    passcodeSubject.value += key.value;

    if (_code.length == _passCodeLength) {
      onComplete();
    }
  }

  void onComplete() {
    if (_code == '123456') {
      NavigationService().navigateTo(Routes.main);
    } else {
      passcodeSubject.addError(ArgumentError());
      Future.delayed(const Duration(seconds: 1)).then((value) => passcodeSubject.add(''));
    }
  }
}
