import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'viewmodels/ProjectViewModel.dart'; // Import the dart:convert library

class UserDataProvider extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  List<String> projects = []; // Store the project names here

  // Other user-related data
  ProjectViewModel projectViewModel = ProjectViewModel();

  Future<void> fetchProjects() async {
    if (_currentUser != null) {
      final ref = _storage.ref('users/${_currentUser!.uid}/projects');
      final ListResult result = await ref.listAll();

      projects = result.items.map((item) => item.name).toList();
      notifyListeners();
    }
  }

  Future<void> createProject(String projectName) async {
    if (_currentUser != null) {
      try {
        final ref = _storage
            .ref('users/${_currentUser!.uid}/projects/$projectName.yaml');
        final data = {'projectName': projectName, 'otherData': 'example'};
        final jsonString =
            jsonEncode(data); // Use jsonEncode to convert to JSON

        await ref.putString(jsonString);

        await fetchProjects(); // Update projects list
      } catch (error) {
        print("Error creating project: $error");
      }
    }
  }
}
