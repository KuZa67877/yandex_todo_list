// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String?,
      taskInfo: json['text'] as String?,
      taskMode:
          $enumDecodeNullable(_$TaskStatusModeEnumMap, json['importance']) ??
              TaskStatusMode.basic,
      taskDeadline: Task._fromJsonNullable((json['deadline'] as num?)?.toInt()),
      done: json['done'] as bool? ?? false,
      color: json['color'] as String? ?? "#FFFFFF",
      createdAt: Task._fromJson((json['created_at'] as num).toInt()),
      changedAt: Task._fromJson((json['changed_at'] as num).toInt()),
      lastUpdatedBy: json['last_updated_by'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.taskInfo,
      'importance': _$TaskStatusModeEnumMap[instance.taskMode]!,
      'deadline': Task._toJsonNullable(instance.taskDeadline),
      'done': instance.done,
      'color': instance.color,
      'created_at': Task._toJson(instance.createdAt),
      'changed_at': Task._toJson(instance.changedAt),
      'last_updated_by': instance.lastUpdatedBy,
    };

const _$TaskStatusModeEnumMap = {
  TaskStatusMode.low: 'low',
  TaskStatusMode.basic: 'basic',
  TaskStatusMode.important: 'important',
};
