import 'package:flutter/material.dart';
import 'package:work_time_app/models/WorkSession.dart';

import '../models/Project.dart'; // Adjust the import path as needed

class WorkSessionViewModel extends ChangeNotifier {
  Project? _selectedProject; // The selected project
  List<WorkSession> _workSessions =
      []; // Work sessions for the selected project

  Project? get selectedProject => _selectedProject;
  List<WorkSession> get workSessions => _workSessions;

  void selectProject(Project project) {
    _selectedProject = project;
    _workSessions = project
        .workSessions.items; // Load work sessions for the selected project
    notifyListeners();
  }
}
