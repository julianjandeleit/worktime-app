import 'package:json_annotation/json_annotation.dart';

import '../util/serializable.dart';
import 'WorkSession.dart';

part 'Project.g.dart'; // This is the generated file from json_serializable

@JsonSerializable(explicitToJson: true)
class Project implements Serializable {
  final String name;
  final List<WorkSession> workSessions;

  Project({
    required this.name,
    required this.workSessions,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
