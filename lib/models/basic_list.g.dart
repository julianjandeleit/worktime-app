// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicList<T> _$BasicListFromJson<T extends Recipeable>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BasicList<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
      selectable: json['selectable'] as bool? ?? false,
      selectedIndex: json['selectedIndex'] as int?,
    );

Map<String, dynamic> _$BasicListToJson<T extends Recipeable>(
  BasicList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items.map(toJsonT).toList(),
      'selectable': instance.selectable,
      'selectedIndex': instance.selectedIndex,
    };
