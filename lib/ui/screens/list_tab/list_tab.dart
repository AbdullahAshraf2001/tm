import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/list_provider.dart';
import 'task_widget.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              children: [
                FilterChipWidget(label: "All", filter: "all"),
                FilterChipWidget(label: "Completed", filter: "completed"),
                FilterChipWidget(label: "Pending", filter: "pending"),
              ],
            ),
          ),

          // Task List
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, provider, child) {
                if (provider.tasks.isEmpty) {
                  return const Center(child: Text("No tasks available"));
                }
                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: provider.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskWidget(index: index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final String filter;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return FilterChip(
      label: Text(label),
      selected: provider.filter == filter,
      onSelected: (_) {
        provider.setFilter(filter);
      },
    );
  }
}
