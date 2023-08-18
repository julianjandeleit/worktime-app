import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_time_app/recipes/classrecipe.dart';
import 'package:work_time_app/util/recipeable.dart';
import 'models/Project.dart'; // Adjust the import path as needed
import 'models/WorkSession.dart'; // Adjust the import path as needed
import 'viewmodels/ProjectViewModel.dart'; // Adjust the import path as needed
import 'viewmodels/WorkSessionViewModel.dart'; // Adjust the import path as needed
import 'views/ProjectView.dart';
import 'views/WorkSessionView.dart'; // Adjust the import path as needed

class Workspace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectViewModel = Provider.of<ProjectViewModel>(context);
    final workSessionViewModel = Provider.of<WorkSessionViewModel>(context);

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
          Flexible(
              flex: 10,
              child: projectViewModel.projects.isNotEmpty
                  ? projectViewModel.projects[0].buildRecipe(
                      onChanged: (updated) {
                        projectViewModel.projects[0] = updated as Project;
                        projectViewModel.notifyListeners();
                      },
                    )
                  : Container()),
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
          if (workSessionViewModel.selectedProject != null)
            WorkSessionView(workSessionViewModel: workSessionViewModel),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          projectViewModel.addProject("new Project");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
