import 'WorkSession.dart';

class Project {
  final String name;
  final List<WorkSession> workSessions;

  Project({
    required this.name,
    required this.workSessions,
  });

  Project.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        workSessions = (json['workSessions'] as List)
            .map((session) => WorkSession(
                  startTime: DateTime.parse(session['startTime']),
                  endTime: DateTime.parse(session['endTime']),
                ))
            .toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'workSessions': workSessions.map((session) => {
              'startTime': session.startTime.toIso8601String(),
              'endTime': session.endTime.toIso8601String(),
            }).toList(),
      };
}
