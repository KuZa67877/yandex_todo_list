// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      UUID: json['UUID'] as String,
      taskInfo: json['taskInfo'] as String,
      isDone: json['isDone'] as bool? ?? false,
      taskMode:
          $enumDecodeNullable(_$TaskStatusModeEnumMap, json['taskMode']) ??
              TaskStatusMode.standartMode,
      taskDeadline: json['taskDeadline'] == null
          ? null
          : DateTime.parse(json['taskDeadline'] as String),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'UUID': instance.UUID,
      'isDone': instance.isDone,
      'taskInfo': instance.taskInfo,
      'taskMode': _$TaskStatusModeEnumMap[instance.taskMode]!,
      'taskDeadline': instance.taskDeadline?.toIso8601String(),
    };

const _$TaskStatusModeEnumMap = {
  TaskStatusMode.standartMode: 'standartMode',
  TaskStatusMode.highPriorityMode: 'highPriorityMode',
  TaskStatusMode.lowPriorityMode: 'lowPriorityMode',
};
