import 'package:json_annotation/json_annotation.dart';

part 'task_dto.g.dart';

@JsonSerializable(createToJson: false)
class TaskDto {
  const TaskDto(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.status,
  );

  factory TaskDto.fromJson(Map<String, dynamic> json) => _$TaskDtoFromJson(json);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'status')
  final String status;
}
