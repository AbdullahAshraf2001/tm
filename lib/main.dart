import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/providers/list_provider.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: const MaterialApp(home: HomeScreen()),
    ),
  );
}
