import 'package:flutter/material.dart';
import 'package:work_time_app/viewmodels/ProjectViewModel.dart';

class ProjectView extends StatelessWidget {
  final ProjectViewModel projectViewModel;

  const ProjectView({super.key, required this.projectViewModel});

  @override
  Widget build(BuildContext context) {
    final projects = projectViewModel.projects;

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];

        return ListTile(
          title: Container(
            color: Colors.amber,
            child: Text(project.name.item),
          ),
          onTap: () {},
          tileColor: false ? Colors.blue.withOpacity(0.3) : null,
        );
      },
    );
  }
}
