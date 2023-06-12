import 'package:data/dto/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_response.g.dart';

@JsonSerializable(createToJson: false)
class TaskResponse {
  const TaskResponse(this.tasks, this.pageNumber, this.totalPages);

  factory TaskResponse.fromJson(Map<String, dynamic> json) => _$TaskResponseFromJson(json);

  @JsonKey(name: 'tasks')
  final List<Task> tasks;

  @JsonKey(name: 'pageNumber')
  final int pageNumber;

  @JsonKey(name: 'totalPages')
  final int totalPages;
}
