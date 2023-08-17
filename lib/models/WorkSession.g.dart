// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkSession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkSession _$WorkSessionFromJson(Map<String, dynamic> json) {
  //print("JSON\n${json}\n");

  return WorkSession(
    startTime: DateTime.parse(json['startTime'] as String),
    endTime: DateTime.parse(json['endTime'] as String),
  );
}

Map<String, dynamic> _$WorkSessionToJson(WorkSession instance) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
    };
