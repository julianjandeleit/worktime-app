import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../recipes/classrecipe.dart';
import '../util/recipeable.dart';
import 'WorkSession.dart';

part 'Project.g.dart'; // This is the generated file from json_serializable

@JsonSerializable(explicitToJson: true)
class Project implements Recipeable {
  final String name;
  final List<WorkSession> workSessions;

  Project({
    required this.name,
    required this.workSessions,
  });

  @override
  Widget buildRecipe({void Function(Recipeable)? onChanged}) {
    return ClassRecipe<Project>(
      item: this,
      fromJsonT: Project.fromJson,
      onChanged: (p0) => onChanged?.call(p0),
    );
  }

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
