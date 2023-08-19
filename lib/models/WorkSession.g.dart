// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkSession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkSession _$WorkSessionFromJson(Map<String, dynamic> json) => WorkSession(
      startTime: json['startTime'] == null
          ? null
          : RDatetime.fromJson(json['startTime'] as Map<String, dynamic>),
      endTime: json['endTime'] == null
          ? null
          : RDatetime.fromJson(json['endTime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkSessionToJson(WorkSession instance) =>
    <String, dynamic>{
      'startTime': instance.startTime?.toJson(),
      'endTime': instance.endTime?.toJson(),
    };
