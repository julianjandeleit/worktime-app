import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateProjectScreen extends StatelessWidget {
  final TextEditingController _projectNameController = TextEditingController();

  void _createProject(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final projectName = _projectNameController.text;

    // Create a new project document
    await FirebaseFirestore.instance.collection('projects').add({
      'userId': userId,
      'name': projectName,
    });

    Navigator.pop(context); // Return to MainScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Project')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _projectNameController,
              decoration: InputDecoration(labelText: 'Project Name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _createProject(context),
              child: Text('Create Project'),
            ),
          ],
        ),
      ),
    );
  }
}
