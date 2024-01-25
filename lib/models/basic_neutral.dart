import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../util/recipeable.dart';

part 'basic_neutral.g.dart';

@JsonSerializable(explicitToJson: true)
class BasicNeutral extends Recipeable {
  BasicNeutral();

  factory BasicNeutral.fromJson(Map<String, dynamic> json) =>
      _$BasicNeutralFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BasicNeutralToJson(this);

  @override
  Widget buildRecipe({void Function(Recipeable p1)? onChanged}) {
    // TODO: implement buildRecipe
    return Container();
  }
}
