import 'dart:io';
import 'package:flutter/material.dart';
import '../../../db/functions/db_functions.dart';
import '../../../db/model/data_model.dart';
import '../../Profile/widgets/profile_screen.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  @override
  void initState() {
    DBFunctions.instance.getAllStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student list'),
      ),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          if (studentList.isEmpty) {
            return const Center(
              child: Text(
                "Student list is empty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentList[index];
              return ListTile(
                title: Text(data.name),
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    File(data.imagePath),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    print("Added data ${data.id}");
                    deleteStudentAlert(context, data.id!);

                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(data: data, index: index),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: studentList.length,
          );
        },
      ),
    );
  }

  void deleteStudentAlert(context, int id) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Are you sure want to delete ?'),
          actions: [
            TextButton(
                onPressed: () async {
                  await DBFunctions.instance.deleteStudent(id);
                  Navigator.of(context).pop();
                  showSnackbar();
                },
                child: const Text('Yes')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            )
          ],
        );
      },
    );
  }

  showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deleted successfully'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
      ),
    );
  }
}
