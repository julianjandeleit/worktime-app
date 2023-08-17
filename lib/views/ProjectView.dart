import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_time_app/viewmodels/ProjectViewModel.dart';
import 'package:work_time_app/models/Project.dart';

class ProjectView extends StatelessWidget {
  final ProjectViewModel projectViewModel;

  ProjectView({required this.projectViewModel});

  @override
  Widget build(BuildContext context) {
    final projects = projectViewModel.projects;
    final selectedProject = projectViewModel.selectedProject;

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        final isSelected = project == selectedProject;

        return ListTile(
          title: Container(
            child: Text(project.name.item),
            color: Colors.amber,
          ),
          onTap: () {
            projectViewModel.selectProject(project);
          },
          tileColor: isSelected ? Colors.blue.withOpacity(0.3) : null,
        );
      },
    );
  }
}
