import '../util/serializable.dart';
import 'WorkSession.dart';

class Project implements Serializable {
  final String name;
  final List<WorkSession> workSessions;

  Project({
    required this.name,
    required this.workSessions,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'workSessions': workSessions.map((ws) => ws.toMap()).toList(),
    };
  }

  @override
  Project fromMap(Map<String, dynamic> map) {
    return Project(
      name: map['name'],
      workSessions: (map['workSessions'] as List<dynamic>)
          .map<WorkSession>((wsMap) => WorkSession.fromMap(wsMap))
          .toList(),
    );
  }
}
