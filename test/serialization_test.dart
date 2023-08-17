import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:work_time_app/models/Project.dart';
import 'package:work_time_app/models/WorkSession.dart';
import 'package:work_time_app/models/basic_list.dart';
import 'package:work_time_app/models/basic_string.dart'; // Replace with your actual import

void main() {
  test('Serialization and deserialization', () {
    // final project1 = Project(
    //   name: BasicString(item: 'Project 1'),
    //   workSessions: BasicList(items: [
    //     WorkSession(
    //       startTime: DateTime.now(),
    //       endTime: DateTime.now().add(Duration(hours: 1)),
    //     ),
    //     WorkSession(
    //       startTime: DateTime.now(),
    //       endTime: DateTime.now().add(Duration(hours: 2)),
    //     ),
    //   ]),
    // );

    // final project2 = Project(
    //   name: BasicString(item: 'Project 2'),
    //   workSessions: BasicList(items: [
    //     WorkSession(
    //       startTime: DateTime.now(),
    //       endTime: DateTime.now().add(Duration(hours: 3)),
    //     ),
    //   ]),
    // );

    // final projects = BasicList<Project>(
    //   items: [project1, project2],
    // );

    // // Convert BasicList to JSON
    // final json = projects.toJson();
    // print(json);

    // // Convert JSON back to BasicList
    // final decodedProjects = BasicList<Project>.fromJson(
    //   json,
    //   (p0) => Project.fromJson(p0 as Map<String, dynamic>),
    // );
    // print(decodedProjects);

    // print(
    //     "debug\n${projects.items[0].name.item} ${decodedProjects.items[0].name.item}");

    // expect(decodedProjects.items.length, projects.items.length);
    // expect(decodedProjects.items[0].name.item, projects.items[0].name.item);
    // expect(decodedProjects.items[0].workSessions.items.length,
    //     projects.items[0].workSessions.items.length);
    // expect(decodedProjects.items[0].workSessions.items[0].startTime,
    //     projects.items[0].workSessions.items[0].startTime);

    final session = WorkSession(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)));

    final sJson = session.toJson();
    // print("workSession json ${sJson}");
    final sDec = WorkSession.fromJson(sJson);
    print("decoded json ${sDec.toJson()}");

    final workSessions = BasicList<WorkSession>(items: [
      WorkSession(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)),
      ),
      WorkSession(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 2)),
      ),
    ]);

    final encodedSessions = workSessions.toJson();

    print("encodedSessions\n${encodedSessions}");
    final decodedSessions = BasicList<WorkSession>.fromJson(
      encodedSessions,
      (p0) => WorkSession.fromJson(p0 as Map<String, dynamic>),
    );

    print("decodedSessions\n${decodedSessions}");
  });
}
