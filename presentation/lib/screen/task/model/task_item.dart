abstract class TaskItem {
  const TaskItem(this.title);

  final String title;
}

class HeaderTaskItem extends TaskItem {
  const HeaderTaskItem(super.title);
}

class ContentTaskItem extends TaskItem {
  const ContentTaskItem(super.title, this.id, this.description);

  final String id;
  final String description;
}
