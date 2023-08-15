import 'package:flutter/material.dart';

import '../models/Project.dart';

class ProjectViewModel extends ChangeNotifier {
  List<Project> _projects = []; // List of projects
  Project? _selectedProject; // Selected project

  List<Project> get projects => _projects;
  Project? get selectedProject => _selectedProject;

  void addProject(String projectName) {
    final newProject = Project(name: projectName, workSessions: []);
    projects.add(newProject);
    notifyListeners(); // Notify listeners of the data change
  }

  void deleteProject(Project project) {
    projects.remove(project);
    notifyListeners(); // Notify listeners of the data change
  }

  void selectProject(Project project) {
    _selectedProject = project;
    notifyListeners();
  }
}
