import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_time_app/models/RDatetime.dart';
import 'package:work_time_app/models/basic_list.dart';
import 'package:work_time_app/models/start_stop.dart';
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
      body: Column(children: [
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
        Flexible(
            child: Text(projectViewModel.selectedProjectIndex != null
                ? projectViewModel
                    .projects[projectViewModel.selectedProjectIndex!].name.item
                : "not selected")),
        Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: projectViewModel.startStopWorkSession.buildRecipe(
                onChanged: (p1) {
                  //TODO: hotfix, to be removed if can be handled properly
                  if (projectViewModel.projects.isNotEmpty) {
                    projectViewModel.selectedProjectIndex = 0;
                  }
                  if (projectViewModel.selectedProjectIndex == null) {
                    return;
                  }

                  var update = p1 as StartStop<WorkSession>;

                  if (update.is_started == true &&
                      projectViewModel.startStopWorkSession.is_started ==
                          false) {
                    // just started recording
                    update.child = WorkSession(
                        startTime: RDatetime(item: DateTime.now()),
                        endTime: null);
                  }
                  if (update.is_started == false &&
                      projectViewModel.startStopWorkSession.is_started ==
                          true) {
                    // just stopped recording
                    update.child = WorkSession(
                        startTime: update.child.startTime,
                        endTime: RDatetime(item: DateTime.now()));

                    projectViewModel.projects
                        .elementAt(projectViewModel.selectedProjectIndex!)
                        .workSessions
                        .items
                        .add(update.child);

                    update = StartStop<WorkSession>(
                        is_started: false,
                        child: WorkSession(startTime: null, endTime: null));
                  }

                  // other cases are change in worksession

                  projectViewModel.startStopWorkSession = update;

                  projectViewModel.notifyListeners();
                },
              ),
            )),
        Flexible(
            flex: 10,
            child: BasicList<Project>(
                    items: projectViewModel.projects,
                    selectable: true,
                    selectedIndex: projectViewModel.selectedProjectIndex)
                .buildRecipe(onChanged: (updated) {
              //print("top level update ${updated}");
              projectViewModel.projects = (updated as BasicList<Project>).items;
              projectViewModel.selectedProjectIndex =
                  (updated as BasicList<Project>).selectedIndex;
              projectViewModel.notifyListeners();
            })),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          projectViewModel.addProject("new Project");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
