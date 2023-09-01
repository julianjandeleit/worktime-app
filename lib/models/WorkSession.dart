import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
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
    if (startTime == null) {
      return Text("not set");
    }

    final widgets = [
      Align(
        alignment: Alignment.center,
        child: Text(
          "Start-, Endtime",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Text(
          "Duration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 25, bottom: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "${startTime!.item.hour.toString().padLeft(2, '0')}:${startTime!.item.minute.toString().padLeft(2, '0')}"),
            endTime != null
                ? Text(
                    "${endTime!.item.day != startTime!.item.day ? "(" + endTime!.item.day.toString() + ".) " : ""}${endTime!.item.hour.toString().padLeft(2, '0')}:${endTime!.item.minute.toString().padLeft(2, '0')}")
                : const Text("..."),
          ],
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Builder(
          builder: (context) {
            var timeDelayEnd = endTime?.item ?? DateTime.now();

            var delay = timeDelayEnd.difference(startTime!.item);
            var hours = delay.inHours;
            var minutes = delay.inMinutes;
            minutes = minutes % 60;

            return Text(
                "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}");
          },
        ),
      ),
    ];

    //return Text("hi");

    return Builder(
      builder: (context) {
        return InkWell(
          onLongPress: () {
            // Open the ClassRecipe<WorkSession> here
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Edit Work Session'),
                  content: SizedBox(
                    height: 300,
                    width: 400,
                    child: ClassRecipe<WorkSession>(
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
                      onChanged: (p0) {
                        print("changed to ${p0.toJson()}");
                        onChanged?.call(p0);
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "${startTime!.item.day}. ${DateFormat('MMMM').format(startTime!.item)} ${startTime!.item.year}",
                ),
              ),
              AlignedGridView.count(
                shrinkWrap: true,
                itemCount: 4,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemBuilder: (context, index) {
                  return widgets[index];
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
