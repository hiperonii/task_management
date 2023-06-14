import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:presentation/screen/passcode/widgets/key_symbols.dart';

import 'package:task_management/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('TaskList test', () {
    tearDown(() {
      GetIt.instance.reset(dispose: false);
    });

    testWidgets('''1. Task list should be able to scroll 
                   2. Task list able to switch tab''', (tester) async {
      app.main();
      // Wait for UI settle, expect to see passcode screen
      await tester.pumpAndSettle();
      expect(_findByKey('Keyboard'), findsOneWidget);

      // Input correct passcode, expect to navigate to main screen
      await _tapVirtualKeyboard(tester, KeySymbols.one);
      await _tapVirtualKeyboard(tester, KeySymbols.two);
      await _tapVirtualKeyboard(tester, KeySymbols.three);
      await _tapVirtualKeyboard(tester, KeySymbols.four);
      await _tapVirtualKeyboard(tester, KeySymbols.five);
      await _tapVirtualKeyboard(tester, KeySymbols.six);

      // Wait for UI settle, expect to see to-do tab
      await tester.pumpAndSettle();
      expect(_findByKey('TODO'), findsOneWidget);

      // Wait for API load, expect to see first item
      await _waitForAction(tester);
      expect(_findByText('Read a book'), findsOneWidget);

      // Loop scroll to bottom of the list, expect list able to scroll by seeing last item of the list
      for (int i = 0; i < 8; i++) {
        await tester.drag(find.byType(ListView), const Offset(0, -400));
        await _waitForAction(tester);
      }
      expect(_findByText('Buy groceries'), findsOneWidget);

      // Tap `Doing` tab, expect to see item in the doing list
      await _tapByKey(tester, 'DOING');
      await _waitForAction(tester);
      expect(_findByText('The best way to predict the future is to invent it.'), findsOneWidget);
    });
  });

  group('Passcode test', () {
    tearDown(() {
      GetIt.instance.reset(dispose: false);
    });

    testWidgets('''1. Passcode should be navigate to main screen only if code is correct 
                   2. Lock on inactive duration''', (tester) async {
      app.main();
      // Wait for UI settle, expect to see passcode screen
      await tester.pumpAndSettle();
      expect(_findByKey('Keyboard'), findsOneWidget);

      // Input incorrect passcode, expect to see error message
      await _tapVirtualKeyboard(tester, KeySymbols.seven);
      await _tapVirtualKeyboard(tester, KeySymbols.seven);
      await _tapVirtualKeyboard(tester, KeySymbols.seven);
      await _tapVirtualKeyboard(tester, KeySymbols.seven);
      await _tapVirtualKeyboard(tester, KeySymbols.seven);
      await _tapVirtualKeyboard(tester, KeySymbols.seven);
      await _waitForAction(tester, const Duration(milliseconds: 200));
      expect(_findByText('Incorrect passcode'), findsOneWidget);

      // Wait for 1 second, expect the error message to disappear
      await _waitForAction(tester, const Duration(seconds: 1));
      expect(_findByText('Incorrect passcode'), findsNothing);

      // Input correct passcode, expect to navigate to main screen
      await _tapVirtualKeyboard(tester, KeySymbols.one);
      await _tapVirtualKeyboard(tester, KeySymbols.two);
      await _tapVirtualKeyboard(tester, KeySymbols.three);
      await _tapVirtualKeyboard(tester, KeySymbols.four);
      await _tapVirtualKeyboard(tester, KeySymbols.five);
      await _tapVirtualKeyboard(tester, KeySymbols.six);

      // Wait for UI settle, expect to see to-do tab
      await tester.pumpAndSettle();
      expect(_findByKey('TODO'), findsOneWidget);

      // Wait for 9 seconds then active the screen, expect to stay on main screen
      await _waitForAction(tester, const Duration(seconds: 8));
      await _tapByKey(tester, 'DONE');
      expect(_findByKey('TODO'), findsOneWidget);

      // Wait for 10 seconds, expect to see passcode screen
      await _waitForAction(tester, const Duration(seconds: 10));
      await tester.pumpAndSettle();
      await _waitForAction(tester);
      expect(_findByKey('Keyboard'), findsOneWidget);
    });
  });
}

Finder _findByKey(String id) {
  return find.byKey(ValueKey(id));
}

Finder _findByText(String text) {
  return find.text(text);
}

Future<void> _tapByKey(WidgetTester tester, String id) {
  return tester.tap(find.byKey(ValueKey(id)));
}

Future<void> _tapVirtualKeyboard(WidgetTester tester, KeySymbols key) {
  return tester.tap(find.byKey(ValueKey('$key')));
}

Future<void> _waitForAction(WidgetTester tester, [Duration duration = const Duration(milliseconds: 800)]) {
  return tester.pump(duration);
}
