import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class Serializable {
  const Serializable();

  Map<String, dynamic> toJson();

  static T fromJson<T>(Map<String, dynamic> json) {
    return _$SerializableFromJson<T>(json);
  }
}

T _$SerializableFromJson<T>(Map<String, dynamic> json) {
  return json as T;
}
