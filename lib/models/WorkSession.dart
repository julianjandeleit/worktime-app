import 'package:flutter/material.dart';

import '../util/recipeable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'WorkSession.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkSession implements Recipeable {
  final DateTime startTime;
  final DateTime endTime;

  WorkSession({
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget buildRecipe() {
    return Container();
  }

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory WorkSession.fromJson(Map<String, dynamic> json) =>
      _$WorkSessionFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WorkSessionToJson(this);
}
