import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_time_app/models/basic_list.dart';
import 'package:work_time_app/models/basic_neutral.dart';
import 'package:work_time_app/models/basic_string.dart';
import 'package:work_time_app/recipes/aggregationrecipe.dart';
import 'package:work_time_app/recipes/listrecipe.dart';

import '../recipes/classrecipe.dart';
import '../util/recipeable.dart';
import 'WorkSession.dart';

part 'Project.g.dart'; // This is the generated file from json_serializable

@JsonSerializable(explicitToJson: true)
class Project extends Recipeable {
  final BasicString name;
  final BasicList<WorkSession> workSessions;

  Project({
    required this.name,
    required this.workSessions,
  });

  @override
  Widget buildRecipe({void Function(Recipeable)? onChanged}) {
    return ClassRecipe<Project>(
      name: "Project",
      item: this,
      fromJson: (p0, {attrname}) {
        switch (attrname) {
          case null:
            return Project.fromJson(p0);
          case "name":
            return BasicString.fromJson(p0);
          case "workSessions":
            return BasicList<WorkSession>.fromJson(
                p0, (p0) => WorkSession.fromJson(p0 as Map<String, dynamic>));
        }

        throw ArgumentError();
      },
      onChanged: (p0) {
        //   print("onchanged called in project");
        onChanged?.call(p0);
      },
    );
  }

  @override
  Widget buildAggregation({void Function(Recipeable)? onChanged}) {
    return AggregationRecipe(
      heading: this.name.item,
      names: ["worksessions", "total time"],
      values: [
        this.workSessions.items.length.toString(),
        workSessions.items
                .map((e) =>
                    e.endTime?.item
                        .difference(e.startTime?.item ?? e.endTime!.item)
                        .abs()
                        .inMinutes ??
                    0)
                .fold(0, (p, e) => p + e)
                .toString() +
            " min"
      ],
      buildDetails: () => buildRecipe(
        onChanged: (p0) => onChanged?.call(p0),
      ),
    );
  }

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
