import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_to_do_app/main.dart' as app;

void main() {
  group('Add Task Integration Test', () {
    testWidgets('Add Task Test', (WidgetTester tester) async {
      // Запуск приложения
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(app.MyApp(
        prefs: prefs,
      ));

      // Ожидание загрузки основного экрана
      await tester.pumpAndSettle();

      // Нажатие на кнопку добавления задачи
      await tester.tap(find.byKey(const ValueKey('add_task_button')));
      await tester.pumpAndSettle();

      // Проверка открытия экрана изменения задачи
      expect(find.byKey(const ValueKey("change_task_screen")), findsOneWidget);

      // Поиск текстового поля и ввод текста
      await tester.enterText(
          find.byKey(const ValueKey("text_field")), 'Новая задача');

      // Сохранение задачи
      await tester.tap(find.byKey(const ValueKey("save_task")));
      await tester.pumpAndSettle();

      // Проверка, что задача добавлена на главный экран
      expect(find.text('Новая задача'), findsOneWidget);
    });
  });
}
