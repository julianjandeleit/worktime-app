import 'package:flutter/material.dart';
import '../models/Project.dart';
import '../viewmodels/ProjectViewModel.dart';

class ProjectView extends StatelessWidget {
  final ProjectViewModel projectViewModel;

  ProjectView({required this.projectViewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: projectViewModel.projects.length,
            itemBuilder: (context, index) {
              final project = projectViewModel.projects[index];
              return ListTile(
                title: Text(project.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => projectViewModel.deleteProject(project),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _addProject(context, projectViewModel),
          child: Text('Add Project'),
        ),
      ],
    );
  }

  void _addProject(BuildContext context, ProjectViewModel viewModel) {
    // Use viewModel to add a new project
    viewModel.addProject('New Project');
  }
}
