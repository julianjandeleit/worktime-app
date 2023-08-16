import 'package:json_annotation/json_annotation.dart';
import '../util/serializable.dart';

part 'basic_list.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BasicList<T extends Serializable> {
  final List<T> items;

  BasicList({required this.items});

  factory BasicList.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$BasicListFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      _$BasicListToJson(this, toJsonT);
}
