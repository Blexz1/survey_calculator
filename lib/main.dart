import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/project_repository.dart';
import 'business/cubit/home_cubit.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const SurveyorCalcProApp());
}

class SurveyorCalcProApp extends StatelessWidget {
  const SurveyorCalcProApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the Repository and provide the Cubit to the widget tree.
    return RepositoryProvider(
      create: (context) => ProjectRepository(),
      child: BlocProvider(
        create: (context) => HomeCubit(context.read<ProjectRepository>()),
        child: MaterialApp(
          title: 'Surveyor Calc Pro',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(
              0xFF1E212B,
            ), // Main dark background
            fontFamily: 'Inter',
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
