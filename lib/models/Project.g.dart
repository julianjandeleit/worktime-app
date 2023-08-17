// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      name: BasicString.fromJson(json['name'] as Map<String, dynamic>),
      workSessions: BasicList<WorkSession>.fromJson(
          json['workSessions'] as Map<String, dynamic>,
          (value) => WorkSession.fromJson(value as Map<String, dynamic>)),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'name': instance.name.toJson(),
      'workSessions': instance.workSessions.toJson(),
    };
