# yandex_todo_list


Ссылка на apk приложения - https://disk.yandex.ru/d/3RTlMpL7Dm2fAg



Домашнее задание №1:

Сверстаны экраны, реализован свайп по айтему, показ выполненных дел (в качестве отображения пока-что заглушка), реализовано логирование, добавлена иконка для android-версии. 

Домашнее задание №2:

Реализован State-Management (Bloc), добавлено локальное хранение данных (Shared Preferences), реализовано взаимодействие с бекендом, исправлены недочеты на счет архитектуры.

Домашнее задание №3:

Переписал архитектуру, сделал навигацию черезе Navigator 2.0., добавил deeplink, DI через getit, Offline-first работает, добавил тесты.

Домашнее задание №4:

Подключил Firebase analitics, crashlitics, remote control (пока прокидываю бульку с условием на язык устройства и в зависимости от нее меняю цвет иконки таски, более лаконичного решения не додумал пока), подключил темную тему, поддержку landscape-ориентации и больших экранов. Добавил CI. Есть мелкий трабл с freezed - почему то отказывается генериться freezed.dart, закину след. коммитом.

Команды для работы с флейворами:

Команда для сборки тестового окружения:
```
flutter run --flavor=dev
```

Команда для сборки прод. окружения:
```
flutter run --flavor=prod
```

Есть нюанс (прям как в анекдоте) - изначально добавил firebase, а после флейворы(предположительно из-за этого), при попытке запуска команды может выскочить следующая ошибка:
```
No matching client found for package name 'com.example.for_build'
```
для исправления нужно добавить/убрать .dev в конце поля package_name в файле google-services.json. Пока не нашел нормального исправления такого бага, в процессе:(


Скриншоты приложения:


![image](https://github.com/KuZa67877/yandex_todo_list/assets/59613747/03246b74-f8ee-4cb9-9942-c4926f7a36d7)

![image](https://github.com/KuZa67877/yandex_todo_list/assets/59613747/e4f5c8b4-a3db-46a0-b2dd-36f0713ebe76)

![image](https://github.com/KuZa67877/yandex_todo_list/assets/59613747/47d2de9d-e2d2-4669-8c86-752a726fc53e)

![image](https://github.com/KuZa67877/yandex_todo_list/assets/59613747/fb31e20a-8e65-4f04-9b90-1a5ddc5d07c2)

![image](https://github.com/KuZa67877/yandex_todo_list/assets/59613747/0f12bd1d-1d41-405d-8d22-79e0d82b5e32)

![image](https://github.com/user-attachments/assets/02a75e02-bb88-48fa-bcc4-070c88b564b8)


![image](https://github.com/user-attachments/assets/3b87a3ca-a9a3-4297-831e-cf872b3b417b)



