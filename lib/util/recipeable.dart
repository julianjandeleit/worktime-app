import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class Recipeable {
  Map<String, dynamic> toJson();

  Widget buildRecipe();

  static T fromJson<T>(Map<String, dynamic> json) {
    return _$SerializableFromJson<T>(json);
  }
}

T _$SerializableFromJson<T>(Map<String, dynamic> json) {
  return json as T;
}
