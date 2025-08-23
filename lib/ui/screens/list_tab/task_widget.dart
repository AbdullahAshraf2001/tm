import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/list_provider.dart';

class TaskWidget extends StatelessWidget {
  final int index;

  const TaskWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final task = provider.tasks[index];

    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: (_) => provider.toggleTask(index),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => provider.deleteTask(index),
      ),
    );
  }
}
