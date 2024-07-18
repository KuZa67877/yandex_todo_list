import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

enum TaskStatusMode { low, basic, important }

@immutable
@JsonSerializable()
class Task extends Equatable {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'text')
  final String taskInfo;
  @JsonKey(name: 'importance')
  final TaskStatusMode taskMode;
  @JsonKey(
      name: 'deadline', fromJson: _fromJsonNullable, toJson: _toJsonNullable)
  final DateTime? taskDeadline;
  @JsonKey(name: 'done')
  final bool done;
  @JsonKey(name: 'color')
  final String? color;
  @JsonKey(name: 'created_at', fromJson: _fromJson, toJson: _toJson)
  final DateTime createdAt;
  @JsonKey(name: 'changed_at', fromJson: _fromJson, toJson: _toJson)
  final DateTime changedAt;
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;

  Task({
    String? id,
    String? taskInfo,
    this.taskMode = TaskStatusMode.basic,
    this.taskDeadline,
    this.done = false,
    this.color = "#FFFFFF",
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  })  : id = id ?? const Uuid().v4(),
        taskInfo = taskInfo ?? '',
        createdAt = createdAt ?? DateTime.now(),
        changedAt = changedAt ?? DateTime.now(),
        lastUpdatedBy = lastUpdatedBy ?? '';

  Task copyWith({
    String? id,
    String? taskInfo,
    TaskStatusMode? taskMode,
    DateTime? taskDeadline,
    bool? isDone,
    String? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return Task(
      id: id ?? this.id,
      taskInfo: taskInfo ?? this.taskInfo,
      taskMode: taskMode ?? this.taskMode,
      taskDeadline: taskDeadline ?? this.taskDeadline,
      done: isDone ?? done,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }

  static Task fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object?> get props => [
        id,
        taskInfo,
        taskMode,
        taskDeadline,
        done,
        color,
        createdAt,
        changedAt,
        lastUpdatedBy,
      ];

  static DateTime _fromJson(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  static int _toJson(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;

  static DateTime? _fromJsonNullable(int? timestamp) => timestamp != null
      ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
      : null;

  static int? _toJsonNullable(DateTime? date) =>
      date?.millisecondsSinceEpoch != null
          ? date!.millisecondsSinceEpoch ~/ 1000
          : null;
}
