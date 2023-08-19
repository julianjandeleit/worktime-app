import 'package:flutter/material.dart';
import 'package:work_time_app/models/RDatetime.dart';
import 'package:work_time_app/models/WorkSession.dart';
import 'package:work_time_app/models/basic_list.dart';
import 'package:work_time_app/models/basic_string.dart';

import '../models/Project.dart';
import '../models/start_stop.dart';

class ProjectViewModel extends ChangeNotifier {
  List<Project> _projects = []; // List of projects
  int? selectedProjectIndex; // Selected project

  StartStop<WorkSession> startStopWorkSession = StartStop(
      is_started: false, child: WorkSession(startTime: null, endTime: null));

  List<Project> get projects => _projects;
  set projects(List<Project> projects) => _projects = projects;

  void addProject(String projectName) {
    final newProject = Project(
        name: BasicString(item: projectName),
        workSessions: BasicList(items: []));
    projects.add(newProject);
    notifyListeners(); // Notify listeners of the data change
  }

  void deleteProject(Project project) {
    projects.remove(project);
    notifyListeners(); // Notify listeners of the data change
  }
}
