import 'package:domain/domain.dart';

class Task {
  Task(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.status,
  );

  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final Status status;
}
