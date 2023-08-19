import 'package:flutter/material.dart';
import 'package:work_time_app/recipes/classrecipe.dart';

import '../util/recipeable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'RDatetime.dart';

part 'WorkSession.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkSession implements Recipeable {
  final RDatetime? startTime;
  final RDatetime? endTime;

  WorkSession({
    required this.startTime,
    required this.endTime,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory WorkSession.fromJson(Map<String, dynamic> json) =>
      _$WorkSessionFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WorkSessionToJson(this);

  @override
  Widget buildRecipe({void Function(Recipeable p1)? onChanged}) {
//    return Text("work session");

    return ClassRecipe<WorkSession>(
      name: "WorkSession",
      item: this,
      fromJson: (p0, {attrname}) {
        switch (attrname) {
          case null:
            return WorkSession.fromJson(p0);
          case "startTime":
            return RDatetime.fromJson(p0);
          case "endTime":
            return RDatetime.fromJson(p0);
        }

        throw ArgumentError();
      },
      onChanged: (p0) => onChanged?.call(p0),
    );
  }
}
