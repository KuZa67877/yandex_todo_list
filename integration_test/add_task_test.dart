import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yandex_to_do_app/main.dart' as app;

void main() {
  group('Add Task Integration Test', () {
    testWidgets('Add Task Test', (WidgetTester tester) async {
      await tester.pumpWidget(const app.MyApp());

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('add_task_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey("change_task_screen")), findsOneWidget);

      await tester.enterText(
          find.byKey(const ValueKey("text_field")), 'Новая задача');

      await tester.tap(find.byKey(const ValueKey("save_task")));
      await tester.pumpAndSettle();

      expect(find.text('Новая задача'), findsOneWidget);
    });
  });
}
