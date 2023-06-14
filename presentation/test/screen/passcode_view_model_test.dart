import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/screen/passcode/passcode_view_model.dart';
import 'package:presentation/screen/passcode/widgets/key_symbols.dart';
import 'package:presentation/service/navigation/navigation_service.dart';
import 'package:presentation/service/navigation/routes.dart';
import 'package:presentation/service/passcode/passcode_service.dart';
import 'package:mocktail/mocktail.dart';

class NavigationServiceMock extends Mock implements NavigationService {}

class PasscodeServiceMock extends Mock implements PasscodeService {}

void main() {
  late PasscodeViewModel sut;
  late PasscodeServiceMock passcodeServiceMock;
  late NavigationServiceMock navigationServiceMock;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    passcodeServiceMock = PasscodeServiceMock();
    navigationServiceMock = NavigationServiceMock();

    sut = PasscodeViewModel(passcodeServiceMock, navigationServiceMock);
  });

  test('input key to onKeyTap()', () {
    sut.onKeyTap(KeySymbols.one);
    expect(sut.passcodeSubject.value, equals('1'));

    sut.passcodeSubject.add('12345');
    sut.onKeyTap(KeySymbols.two);
    expect(sut.passcodeSubject.value, equals('123452'));

    sut.passcodeSubject.add('123456');
    sut.onKeyTap(KeySymbols.three);
    expect(sut.passcodeSubject.value, equals('123456'));

    sut.passcodeSubject.add('1234567');
    sut.onKeyTap(KeySymbols.four);
    expect(sut.passcodeSubject.value, equals('1234567'));

    sut.passcodeSubject.add('12345');
    sut.onKeyTap(KeySymbols.five);
    expect(sut.passcodeSubject.hasError, true);
  });

  test('show error when input incorrect passcode', () {
    sut.passcodeSubject.add('12345');
    sut.onKeyTap(KeySymbols.five);
    expect(sut.passcodeSubject.hasError, true);
  });

  test('navigation to main when input correct passcode', () {
    sut.passcodeSubject.add('12345');
    sut.onKeyTap(KeySymbols.five);
    expect(sut.passcodeSubject.hasError, true);

    when(() => passcodeServiceMock.start()).thenReturn(null);
    when(() => navigationServiceMock.navigateTo(Routes.main)).thenAnswer((_) => Future.value(null));

    sut.passcodeSubject.add('12345');
    sut.onKeyTap(KeySymbols.six);
    verify(() => navigationServiceMock.navigateTo(Routes.main)).called(1);
    verify(() => passcodeServiceMock.start()).called(1);
  });
}
