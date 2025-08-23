import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/list_provider.dart';
import 'list_tab/list_tab.dart';
import 'bottom_sheets/add_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task Manager",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const ListTab(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const AddTaskBottomSheet(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
