import 'package:flutter_test/flutter_test.dart';
import 'package:work_time_app/models/Project.dart';
import 'package:work_time_app/models/WorkSession.dart';
import 'package:work_time_app/models/basic_list.dart'; // Replace with your actual import

void main() {
  test('Serialization and deserialization', () {
    final project1 = Project(
      name: 'Project 1',
      workSessions: [
        WorkSession(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(hours: 1)),
        ),
        WorkSession(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(hours: 2)),
        ),
      ],
    );

    final project2 = Project(
      name: 'Project 2',
      workSessions: [
        WorkSession(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(hours: 3)),
        ),
      ],
    );

    final projects = BasicList<Project>(
      items: [project1, project2],
    );

    // Convert BasicList to JSON
    final json = projects.toJson();
    print(json);

    // Convert JSON back to BasicList
    final decodedProjects = BasicList<Project>.fromJson(
      json,
      (p0) => Project.fromJson(p0 as Map<String, dynamic>),
    );
    print(decodedProjects);

    expect(decodedProjects.items.length, projects.items.length);
    expect(decodedProjects.items[0].name, projects.items[0].name);
    expect(decodedProjects.items[0].workSessions.length,
        projects.items[0].workSessions.length);
    expect(decodedProjects.items[0].workSessions[0].startTime,
        projects.items[0].workSessions[0].startTime);
  });
}
