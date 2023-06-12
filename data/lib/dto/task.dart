import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(createToJson: false)
class Task {
  const Task(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.status,
  );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'status')
  final String status;
}
