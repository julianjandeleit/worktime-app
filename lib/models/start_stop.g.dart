// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartStop<T> _$StartStopFromJson<T extends Recipeable>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    StartStop<T>(
      is_started: json['is_started'] as bool,
      child: fromJsonT(json['child']),
    );

Map<String, dynamic> _$StartStopToJson<T extends Recipeable>(
  StartStop<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'is_started': instance.is_started,
      'child': toJsonT(instance.child),
    };
