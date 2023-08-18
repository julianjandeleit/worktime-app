// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RDatetime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RDatetime _$RDatetimeFromJson(Map<String, dynamic> json) => RDatetime(
      item: DateTime.parse(json['item'] as String),
    );

Map<String, dynamic> _$RDatetimeToJson(RDatetime instance) => <String, dynamic>{
      'item': instance.item.toIso8601String(),
    };
