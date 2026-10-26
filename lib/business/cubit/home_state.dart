part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

// State to show a temporary success/error message overlay
class HomeStatusUpdate extends HomeState {
  final String message;
  final bool isSuccess;

  const HomeStatusUpdate({required this.message, required this.isSuccess});

  @override
  List<Object> get props => [message, isSuccess];
}

class HomeLoaded extends HomeState {
  final List<Project> projects;

  const HomeLoaded({required this.projects});

  @override
  List<Object> get props => [projects];
}
