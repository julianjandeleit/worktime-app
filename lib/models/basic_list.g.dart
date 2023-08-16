// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicList<T> _$BasicListFromJson<T extends Serializable>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BasicList<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$BasicListToJson<T extends Serializable>(
  BasicList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items.map(toJsonT).toList(),
    };
