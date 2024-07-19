import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskStatusMode { low, basic, important }

@freezed
class Task with _$Task {
  const factory Task({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'text') String? taskInfo,
    @JsonKey(name: 'importance')
    @Default(TaskStatusMode.basic)
    TaskStatusMode taskMode,
    @JsonKey(
        name: 'deadline', fromJson: _fromJsonNullable, toJson: _toJsonNullable)
    DateTime? taskDeadline,
    @JsonKey(name: 'done') @Default(false) bool done,
    @JsonKey(name: 'color') @Default("#FFFFFF") String? color,
    @JsonKey(name: 'created_at', fromJson: _fromJson, toJson: _toJson)
    DateTime? createdAt,
    @JsonKey(name: 'changed_at', fromJson: _fromJson, toJson: _toJson)
    DateTime? changedAt,
    @JsonKey(name: 'last_updated_by') String? lastUpdatedBy,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

DateTime _fromJson(int timestamp) =>
    DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

int _toJson(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;

DateTime? _fromJsonNullable(int? timestamp) => timestamp != null
    ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
    : null;

int? _toJsonNullable(DateTime? date) => date?.millisecondsSinceEpoch != null
    ? date!.millisecondsSinceEpoch ~/ 1000
    : null;
