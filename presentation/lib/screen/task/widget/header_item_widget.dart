import 'package:flutter/material.dart';
import 'package:presentation/screen/task/model/task_item.dart';

class HeaderItemWidget extends StatelessWidget {
  const HeaderItemWidget(this._item, {super.key});

  final HeaderTaskItem _item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Colors.purple.shade50, width: 4)),
      ),
      child: Text(_item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }
}
