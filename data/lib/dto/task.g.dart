// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      DateTime.parse(json['createdAt'] as String),
      json['status'] as String,
    );
