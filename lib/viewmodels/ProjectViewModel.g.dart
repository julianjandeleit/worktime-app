// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectViewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectViewModel _$ProjectViewModelFromJson(Map<String, dynamic> json) =>
    ProjectViewModel()
      ..selectedProjectIndex = json['selectedProjectIndex'] as int?
      ..startStopWorkSession = StartStop<WorkSession>.fromJson(
          json['startStopWorkSession'] as Map<String, dynamic>,
          (value) => WorkSession.fromJson(value as Map<String, dynamic>))
      ..projects = (json['projects'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ProjectViewModelToJson(ProjectViewModel instance) =>
    <String, dynamic>{
      'selectedProjectIndex': instance.selectedProjectIndex,
      'startStopWorkSession': instance.startStopWorkSession.toJson(),
      'projects': instance.projects.map((e) => e.toJson()).toList(),
    };
