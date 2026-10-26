import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/project.dart';
import '../../data/repositories/project_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProjectRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());

  void loadInitialData() async {
    // Simulate loading
    // emit(HomeLoading());

    final projects = await repository.fetchRecentProjects();
    emit(HomeLoaded(projects: projects));
  }

  void newProject() {
    // Logic for creating a new project
    showStatusUpdate('New Project created successfully!', isSuccess: true);
  }

  void continueProject() {
    // Logic for continuing an existing project
    showStatusUpdate('Loading last session...', isSuccess: true);
  }

  void checkGps() {
    // Simulate checking GPS status
    showStatusUpdate('GPS signal lost', isSuccess: false);
  }

  void showStatusUpdate(String message, {required bool isSuccess}) {
    emit(HomeStatusUpdate(message: message, isSuccess: isSuccess));
    // The UI handles showing and then resetting the state after a delay
    // For simplicity in this demo, the UI will reset it.
  }
}
