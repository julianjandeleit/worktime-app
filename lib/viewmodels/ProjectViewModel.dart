import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:work_time_app/models/RDatetime.dart';
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

  ProjectViewModel() {
    //listener should handle persistent storage. It gets triggered whenever the data changes.
    addListener(() async {
      final supabase = Supabase.instance.client;
      //only store for valid users
      if (supabase.auth.currentUser == null) {
        return;
      }
      final userID = supabase.auth.currentUser!.id;

      Uint16List bytes = Uint16List.fromList(jsonEncode(toJson()).codeUnits);

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

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory ProjectViewModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectViewModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProjectViewModelToJson(this);
}
