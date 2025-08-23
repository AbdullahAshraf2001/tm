import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/list_provider.dart';
import '../../widgets/my_text_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      height: MediaQuery.of(context).size.height * .4,
      child: Column(
        children: [
          MyTextField(
            controller: taskTitleController,
            hint: "Enter task title",
          ),
          SizedBox(height: 12),

          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              final success = provider.addTask(taskTitleController.text);
              if (!success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Task title cannot be empty"),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text(
              "Add Task",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
