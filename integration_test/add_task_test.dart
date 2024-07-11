import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:yandex_to_do_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add task test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final Finder addButton = find.byKey(const ValueKey('add_task_button'));
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    final Finder textField = find.byKey(const ValueKey('text_field'));
    const String taskText = 'New Task';
    await tester.enterText(textField, taskText);
    await tester.pumpAndSettle();

    final Finder saveButton = find.byKey(const ValueKey('save_task'));
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text(taskText), findsOneWidget);
  });
}
