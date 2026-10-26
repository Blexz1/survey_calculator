import '../models/project.dart';

class ProjectRepository {
  // In a real app, this would call services (API/Database)
  Future<List<Project>> fetchRecentProjects() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Project(
        id: '1',
        name: 'Conte Project',
        lastModified: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Project(
        id: '2',
        name: 'Hilltop Survey',
        lastModified: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}
