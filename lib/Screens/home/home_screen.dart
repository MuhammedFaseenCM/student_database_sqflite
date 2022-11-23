import 'package:flutter/material.dart';
import 'package:student_database/Screens/home/widgets/add_student_widget.dart';
import 'package:student_database/Screens/home/widgets/list_student_widget.dart';
import 'package:student_database/db/functions/db_functions.dart';

class Home_screen extends StatelessWidget {
  const Home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: Container(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              AddStudentWidget(),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ListStudentWidget()));
                  },
                  icon: Icon(Icons.view_agenda),
                  label: Text('View student list'))
            ],
          ),
        ),
      ),
    );
  }
}
