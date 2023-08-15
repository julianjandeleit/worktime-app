import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/ProjectViewModel.dart'; // Update the import path based on your project structure
import 'views/ProjectView.dart'; // Update the import path based on your project structure

class Workspace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectViewModel = Provider.of<ProjectViewModel>(context);
    print(projectViewModel.projects);
    return Scaffold(
      appBar: AppBar(
        title: Text('Workspace'),
        actions: [
          IconButton(
            onPressed: () {
              // Perform any actions you want here
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your Projects',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ProjectView(projectViewModel: projectViewModel),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add project creation logic here
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
