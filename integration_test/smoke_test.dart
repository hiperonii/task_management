import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:presentation/screen/passcode/widgets/key_symbols.dart';

import 'package:task_management/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('Smoke test', () {
    testWidgets('Test task list screen should be able to scroll and switch tab', (tester) async {
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
      await _waitForAction(tester);
      expect(_findByText('Incorrect passcode'), findsOneWidget);

      // Wait for 1 second, expect the error message to disappear
      await _waitForAction(tester, const Duration(seconds: 1));
      expect(_findByText('Incorrect passcode'), findsNothing);

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

      // Loop scroll to bottom of the list, expect to see last item
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
