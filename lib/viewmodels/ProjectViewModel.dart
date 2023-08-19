import 'package:flutter/material.dart';
import 'package:work_time_app/models/RDatetime.dart';
import 'package:work_time_app/models/WorkSession.dart';
import 'package:work_time_app/models/basic_list.dart';
import 'package:work_time_app/models/basic_string.dart';

import '../models/Project.dart';

class ProjectViewModel extends ChangeNotifier {
  List<Project> _projects = []; // List of projects
  Project? _selectedProject; // Selected project

  List<Project> get projects => _projects;
  Project? get selectedProject => _selectedProject;
  set projects(List<Project> projects) => _projects = projects;

  void addProject(String projectName) {
    final newProject = Project(
        name: BasicString(item: projectName),
        workSessions: BasicList(items: [
          WorkSession(
              startTime: null,
              // startTime: RDatetime(item: DateTime.now()),
              endTime: RDatetime(item: DateTime.now().add(Duration(hours: 1))))
        ]));
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
