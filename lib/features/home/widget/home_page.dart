// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yandex_to_do_app/features/change_task/change_task_screen.dart';
// import 'package:yandex_to_do_app/features/home/home.dart';

// import '../../../resourses/colors.dart';
// import '../bloc/home_cubit.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => HomeCubit(),
//       child: const HomeView(),
//     );
//   }
// }

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ToDoMainScreen(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           addTask(context);
//         },
//         backgroundColor: AppColors.lightColorBlue,
//         shape: CircleBorder(),
//         child: const Icon(
//           Icons.add,
//           color: Color.fromARGB(255, 255, 255, 255),
//         ),
//       ),
//     );
//   }
// }
