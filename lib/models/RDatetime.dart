import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_time_app/recipes/datetimerecipe.dart';

import '../util/recipeable.dart';

part 'RDatetime.g.dart';

@JsonSerializable(explicitToJson: true)
class RDatetime implements Recipeable {
  DateTime item;

  RDatetime({required this.item});

  factory RDatetime.fromJson(Map<String, dynamic> json) =>
      _$RDatetimeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RDatetimeToJson(this);

  @override
  Widget buildRecipe({void Function(Recipeable p1)? onChanged}) {
    // TODO: implement buildRecipe
    return DatetimeRecipe(
      initialValue: item,
      onChanged: (p0) => onChanged?.call(RDatetime(item: p0)),
    );
  }
}
