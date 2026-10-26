import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String name;
  final DateTime lastModified;

  const Project({
    required this.id,
    required this.name,
    required this.lastModified,
  });

  @override
  List<Object> get props => [id, name, lastModified];

  // Factory method to create a Project from a map (e.g., JSON response)
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      name: json['name'] as String,
      lastModified: DateTime.parse(json['lastModified'] as String),
    );
  }
}
