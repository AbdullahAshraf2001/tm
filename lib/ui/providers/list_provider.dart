import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'isDone': isDone};
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(title: map['title'], isDone: map['isDone']);
  }
}

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  String _filter = "all";

  TaskProvider() {
    _loadTasks();
  }

  List<Task> get tasks {
    switch (_filter) {
      case "completed":
        return _tasks.where((task) => task.isDone).toList();
      case "pending":
        return _tasks.where((task) => !task.isDone).toList();
      default:
        return _tasks;
    }
  }

  String get filter => _filter;

  bool addTask(String title) {
    if (title.trim().isEmpty) return false;
    _tasks.add(Task(title: title));
    _saveTasks();
    notifyListeners();
    return true;
  }

  void toggleTask(int index) {
    tasks[index].toggleDone();
    _saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.remove(tasks[index]);
    _saveTasks();
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = _tasks.map((task) => task.toMap()).toList();
    prefs.setString("tasks", jsonEncode(taskList));
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString("tasks");
    if (tasksJson != null) {
      final List decoded = jsonDecode(tasksJson);
      _tasks.clear();
      _tasks.addAll(decoded.map((t) => Task.fromMap(t)));
      notifyListeners();
    }
  }
}
