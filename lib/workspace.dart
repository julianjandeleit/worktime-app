import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sf;
import 'package:work_time_app/main.dart';
import 'package:work_time_app/models/RDatetime.dart';
import 'package:work_time_app/models/basic_list.dart';
import 'package:work_time_app/models/start_stop.dart';
import 'models/Project.dart'; // Adjust the import path as needed
import 'models/WorkSession.dart'; // Adjust the import path as needed
import 'viewmodels/ProjectViewModel.dart'; // Adjust the import path as needed
// Adjust the import path as needed
// Adjust the import path as needed

class Workspace extends StatelessWidget {
  const Workspace({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = sf.Supabase.instance.client;

    return Builder(builder: (context) {
      final projectViewModel = Provider.of<ProjectViewModel>(context);
      print("building with ${projectViewModel.toJson()}");
      if (projectViewModel.is_loading == false) {
        return MainWidget(
            userName: projectViewModel.isLoggedIn()
                ? supabase.auth.currentUser?.email ?? "no email provided"
                : "not logged in",
            projectViewModel: projectViewModel);
      } else {
        return const Scaffold(body: Text("loading data"));
      }
    });
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
    required this.userName,
    required this.projectViewModel,
  });

  final String userName;
  final ProjectViewModel projectViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workspace for $userName'),
        actions: [
          IconButton(
            onPressed: () {
              // Perform any actions you want here
              sf.Supabase.instance.client.auth.signOut().then((value) {
                print("navContext: ${navigatorKey.currentContext}");
                Navigator.of(navigatorKey.currentContext!)
                    .popAndPushNamed("/login");
              });
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(children: [
        if (!projectViewModel.isLoggedIn())
          const Text(
            "you are not logged in so your data will not be saved",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Work session will be saved to project:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
            child: Text(
          projectViewModel.selectedProjectIndex != null
              ? projectViewModel
                  .projects[projectViewModel.selectedProjectIndex!].name.item
              : "not selected: select a project in the list below or create a new one by editing it",
          style: TextStyle(
            backgroundColor: projectViewModel.selectedProjectIndex != null
                ? Colors.blueGrey.withOpacity(0.45)
                : Colors.orange,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        )),
        Flexible(
            flex: 6,
            child: StartStopWidget(projectViewModel: projectViewModel)),
        const Text(
          'Your Projects',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          flex: 15,
          child: BasicList<Project>(
                  items: projectViewModel.projects,
                  onAdd: () {
                    projectViewModel.addProject("new Project");
                  },
                  selectable: true,
                  selectedIndex: projectViewModel.selectedProjectIndex)
              .buildAggregation(onChanged: (updated) {
            //print("top level update ${updated}");
            projectViewModel.projects = (updated as BasicList<Project>).items;
            projectViewModel.selectedProjectIndex =
                (updated).selectedIndex;
            projectViewModel.notifyListeners();
          }),
        ),
      ]),
    );
  }
}

class StartStopWidget extends StatelessWidget {
  const StartStopWidget({
    super.key,
    required this.projectViewModel,
  });

  final ProjectViewModel projectViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: projectViewModel.startStopWorkSession.buildRecipe(
        onChanged: (p1) {
          if (projectViewModel.selectedProjectIndex == null) {
            return;
          }

          var update = p1 as StartStop<WorkSession>;

          if (update.is_started == true &&
              projectViewModel.startStopWorkSession.is_started == false) {
            // just started recording
            update.child = WorkSession(
                startTime: RDatetime(item: DateTime.now()), endTime: null);
          }
          if (update.is_started == false &&
              projectViewModel.startStopWorkSession.is_started == true) {
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
    );
  }
}
