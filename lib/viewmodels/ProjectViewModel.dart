import 'dart:convert';
import 'dart:typed_data';

import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:work_time_app/models/WorkSession.dart';
import 'package:work_time_app/models/basic_list.dart';
import 'package:work_time_app/models/basic_string.dart';

import '../models/Project.dart';
import '../models/start_stop.dart';

part 'ProjectViewModel.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectViewModel extends ChangeNotifier {
  List<Project> _projects = []; // List of projects
  int? selectedProjectIndex; // Selected project

  StartStop<WorkSession> startStopWorkSession = StartStop(
      is_started: false, child: WorkSession(startTime: null, endTime: null));

  List<Project> get projects => _projects;
  set projects(List<Project> projects) => _projects = projects;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool is_loading = false;

  ProjectViewModel() {
    final supabase = Supabase.instance.client;
    _projects = [
      Project(
          name: BasicString(item: "My Default Project Name"),
          workSessions: BasicList(items: []))
    ];
    selectedProjectIndex = 0;

    //listener should handle persistent storage. It gets triggered whenever the data changes.
    addListener(() async {
      //only store for valid users
      if (!isLoggedIn()) {
        return;
      }
      final userID = supabase.auth.currentUser!.id;

      Uint16List bytes = Uint16List.fromList(jsonEncode(toJson()).codeUnits);

      //TODO: backend storage should eventually be factored out and injected as an abstract persistant storage handler

      var file = MemoryFileSystem().file('test.json')..writeAsBytesSync(bytes);

      String filename = '$userID.json';
      try {
        var resultMsg =
            await supabase.storage.from('userdata').update(filename, file);
      } catch (e) {
        await supabase.storage
            .from('userdata')
            .upload(filename, file); //TODO: more band width efficient method?
      }

      //   if (fileExists) {
      //     // If the file exists, replace its content
      //     await storage.replace(filename, file);
      //   } else {
      //     // If the file doesn't exist, upload it
      //     await storage.upload(filename, file);
      //   }
      //   final response =
      //       await supabase.storage.from("userdata").update('$userID.json', file);
      //   print("response from saving: $response ${toJson().toString()}");
    });
  }

  bool isLoggedIn() {
    final supabase = Supabase.instance.client;
    return supabase.auth.currentUser != null;
  }

  Future<void> updateFromUser() async {
    try {
      is_loading = true;
      final newModel = await ProjectViewModel.from_user();

      print("building model: $newModel");
      if (newModel == null) {
        return;
      }
      _projects = newModel._projects;
      selectedProjectIndex = newModel.selectedProjectIndex;
      startStopWorkSession = newModel.startStopWorkSession;
    } finally {
      is_loading = false;
    }
  }

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

  static Future<ProjectViewModel?> from_user() async {
    final supabase = Supabase.instance.client;
    //only store for valid users
    if (supabase.auth.currentUser == null) {
      print("current user is null");
      return null;
    }
    final userID = supabase.auth.currentUser!.id;

    String filename = '$userID.json';
    try {
      Uint8List response =
          await supabase.storage.from('userdata').download(filename);
      String content = String.fromCharCodes(response);

      return ProjectViewModel.fromJson(jsonDecode(content));
    } catch (e) {
      return ProjectViewModel();
    }

    return null;
  }

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory ProjectViewModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectViewModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProjectViewModelToJson(this);
}
