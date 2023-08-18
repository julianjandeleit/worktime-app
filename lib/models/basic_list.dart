import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:json_annotation/json_annotation.dart';
import '../util/recipeable.dart';

part 'basic_list.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class BasicList<T extends Recipeable> implements Recipeable {
  final List<T> items;

  BasicList({required this.items});

  factory BasicList.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$BasicListFromJson<T>(json, fromJsonT);

  @override
  Map<String, dynamic> toJson() =>
      _$BasicListToJson<T>(this, (item) => item.toJson());

  @override
  Widget buildRecipe({void Function(Recipeable p1)? onChanged}) {
    // TODO: implement buildRecipe
    return Container();
  }
}