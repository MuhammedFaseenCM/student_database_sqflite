import 'package:flutter/material.dart';
import 'package:student_database/Screens/home/widgets/add_student_widget.dart';
import 'package:student_database/Screens/home/widgets/list_student_widget.dart';
import 'package:student_database/db/functions/db_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DBFunctions.instance.getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
             const AddStudentWidget(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ListStudentWidget(),
                    ),
                  );
                },
                icon: const Icon(Icons.view_agenda),
                label: const Text('View student list'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
