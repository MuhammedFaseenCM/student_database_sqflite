import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_database/Screens/home/widgets/add_student_widget.dart';
import 'package:student_database/Screens/home/widgets/list_student_widget.dart';

class Home_screen extends StatelessWidget {
  const Home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: Container(
        child: Column(
          children: [AddStudentWidget(), Expanded(child: ListStudentWidget())],
        ),
      ),
    );
  }
}
