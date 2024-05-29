import 'package:flutter/material.dart';
import 'package:take_off_checklist/screens/dashboard_screen.dart';

void main() {
  runApp(TakeOffChecklistApp());
}

class TakeOffChecklistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take Off Checklist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}
