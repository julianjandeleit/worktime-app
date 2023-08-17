import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:json_annotation/json_annotation.dart';
import '../util/recipeable.dart';

part 'basic_string.g.dart';

@JsonSerializable(explicitToJson: true)
class BasicString implements Recipeable {
  final String item;

  BasicString({required this.item});

  factory BasicString.fromJson(Map<String, dynamic> json) =>
      _$BasicStringFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BasicStringToJson(this);

  @override
  Widget buildRecipe({void Function(Recipeable p1)? onChanged}) {
    // TODO: implement buildRecipe
    return Text(this.item);
  }
}
