// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) => TaskResponse(
      (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['pageNumber'] as int,
      json['totalPages'] as int,
    );
