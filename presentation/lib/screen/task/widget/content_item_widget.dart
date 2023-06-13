import 'package:flutter/material.dart';
import 'package:presentation/screen/task/model/task_item.dart';

class ContentItemWidget extends StatelessWidget {
  const ContentItemWidget(this._item, {super.key, this.onDelete});

  final ContentTaskItem _item;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_item.id),
      direction: DismissDirection.endToStart,
      onDismissed: _onDismissed,
      background: _buildDismissibleBackground(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 0, 8, 12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle(),
            const SizedBox(height: 8),
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  void _onDismissed(direction) {
    onDelete?.call();
  }

  Widget _buildDismissibleBackground() {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      color: Colors.red,
      child: const Padding(
        padding: EdgeInsets.only(right: 16),
        child: Icon(Icons.delete, color: Colors.white),
      ),
    );
  }

  Widget _buildDescription() {
    return Text(_item.description, style: const TextStyle(height: 1.1));
  }

  Widget _buildTitle() {
    return Text(_item.title, style: const TextStyle(fontWeight: FontWeight.bold, height: 1.2));
  }
}
