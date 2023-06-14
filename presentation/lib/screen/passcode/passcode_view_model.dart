import 'package:presentation/screen/passcode/widgets/key_symbols.dart';
import 'package:presentation/service/navigation/navigation_service.dart';
import 'package:presentation/service/navigation/routes.dart';
import 'package:presentation/service/passcode/passcode_service.dart';
import 'package:rxdart/rxdart.dart';

class PasscodeViewModel {
  PasscodeViewModel(this._passcodeService, this._navigationService);

  static const _passCodeLength = 6;
  static const _correctPasscode = '123456';

  final PasscodeService _passcodeService;
  final NavigationService _navigationService;

  late final BehaviorSubject<String> passcodeSubject = BehaviorSubject.seeded('');

  String get _code => passcodeSubject.value;

  void onKeyTap(KeySymbols key) {
    if (_code.length >= _passCodeLength) {
      return;
    }

    passcodeSubject.value += key.value;

    if (_code.length == _passCodeLength) {
      onComplete();
    }
  }

  void onComplete() {
    if (_code == _correctPasscode) {
      _passcodeService.start();
      _navigationService.navigateTo(Routes.main);
    } else {
      passcodeSubject.addError(ArgumentError());
      Future.delayed(const Duration(milliseconds: 800)).then((value) => passcodeSubject.add(''));
    }
  }
}
