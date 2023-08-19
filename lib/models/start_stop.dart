import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_time_app/recipes/datetimerecipe.dart';

import '../util/recipeable.dart';

part 'start_stop.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class StartStop<T extends Recipeable> implements Recipeable {
  bool is_started;
  T child;
  StartStop({required this.is_started, required this.child});

  factory StartStop.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$StartStopFromJson<T>(json, fromJsonT);

  @override
  Map<String, dynamic> toJson() =>
      _$StartStopToJson<T>(this, (item) => item.toJson());
  @override
  Widget buildRecipe({void Function(Recipeable p1)? onChanged}) {
    // TODO: implement buildRecipe
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomCircularButton(
            buttonText: "start recording",
            onPressed: () {
              onChanged?.call(StartStop(is_started: true, child: child));
            },
            isClickable: this.is_started == false,
          ),
          CustomCircularButton(
            buttonText: "stop recording",
            onPressed: () {
              onChanged?.call(StartStop(is_started: false, child: child));
            },
            isClickable: this.is_started == true,
          ),
          child.buildRecipe(
            onChanged: (p0) => onChanged
                ?.call(StartStop(is_started: is_started, child: p0 as T)),
          )
        ]
            .map((e) => Flexible(
                  child: Container(
                      child: Center(
                    child: e,
                  )),
                ))
            .toList());
  }
}

class CustomCircularButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isClickable;

  CustomCircularButton(
      {required this.buttonText,
      required this.onPressed,
      required this.isClickable});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
        backgroundColor: isClickable ? Colors.blue : Colors.transparent,
        foregroundColor: Colors.white,
        side: isClickable ? BorderSide.none : BorderSide(color: Colors.blue),
      ),
      child: Center(child: Text(buttonText)),
    );
  }
}
