import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task.g.dart';

enum TaskStatusMode { standartMode, highPriorityMode, lowPriorityMode }

@immutable
@JsonSerializable()
class Task extends Equatable {
  late final String UUID;
  final bool isDone;
  final String taskInfo;
  final TaskStatusMode taskMode;
  final DateTime? taskDeadline;

  Task({
    required this.UUID,
    required this.taskInfo,
    this.isDone = false,
    this.taskMode = TaskStatusMode.standartMode,
    this.taskDeadline,
  });

  Task copyWith({
    bool? isDone,
    String? taskInfo,
    TaskStatusMode? taskMode,
    DateTime? taskDeadline,
  }) {
    return Task(
      UUID: this.UUID,
      taskInfo: taskInfo ?? this.taskInfo,
      isDone: isDone ?? this.isDone,
      taskMode: taskMode ?? this.taskMode,
      taskDeadline: taskDeadline ?? this.taskDeadline,
    );
  }

  static Task fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
  @override
  List<Object?> get props => [UUID, isDone, taskInfo, taskMode, taskDeadline];
}
