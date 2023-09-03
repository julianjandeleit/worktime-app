import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_time_app/recipes/TextRecipe.dart';
import '../util/recipeable.dart';

part 'basic_string.g.dart';

@JsonSerializable(explicitToJson: true)
class BasicString extends Recipeable {
  final String item;

  BasicString({required this.item});

  factory BasicString.fromJson(Map<String, dynamic> json) =>
      _$BasicStringFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BasicStringToJson(this);

  @override
  Widget buildRecipe({void Function(Recipeable p1)? onChanged}) {
    // TODO: implement buildRecipe
    return TextRecipe(
      initialText: item,
      onChanged: (p0) => onChanged?.call(BasicString(item: p0)),
    );
  }
}
