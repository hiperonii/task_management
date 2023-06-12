import 'package:flutter/material.dart';
import 'package:presentation/screen/task/model/task_item.dart';

class ContentItemWidget extends StatelessWidget {
  const ContentItemWidget(this._item, {super.key});

  final ContentTaskItem _item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_item.title, style: const TextStyle(fontWeight: FontWeight.bold, height: 1.3)),
          Text(_item.description, style: const TextStyle(height: 1.5)),
        ],
      ),
    );
  }
}
