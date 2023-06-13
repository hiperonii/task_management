import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:task_management/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('Smoke test', () {
    testWidgets('Test task list screen should be able to scroll and switch tab', (tester) async {
      app.main();

      // Wait for UI settle, then expect to see TODO tab
      await tester.pumpAndSettle();
      expect(_findByKey('TODO'), findsOneWidget);

      // Wait for API load, then expect to see first item
      await _waitForAction(tester);
      expect(_findByText('Read a book'), findsOneWidget);

      // Loop scroll to bottom of the list, then expect to see last item
      for(int i = 0; i < 8; i++) {
        await tester.drag(find.byType(ListView), const Offset(0, -400));
        await _waitForAction(tester);
      }
      expect(_findByText('Buy groceries'), findsOneWidget);

      // Tap `Doing` tab, then expect to see item in the doing list
      await _tapByKey(tester, 'DOING');
      await _waitForAction(tester);
      expect(find.widgetWithText(Container, 'The best way to predict the future is to invent it.'), findsOneWidget);
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

Future<void> _waitForAction(WidgetTester tester) {
  return tester.pump(const Duration(milliseconds: 800));
}
