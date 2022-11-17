import 'package:flutter/material.dart';
import 'package:student_database/Screens/home/home_screen.dart';

void main(List<String> args) {
  runApp(Student_App());
}

class Student_App extends StatelessWidget {
  const Student_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Home_screen(),
    );
  }
}
