import 'dart:convert';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student list'),
      ),
      body: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext ctx, List<StudentModel> studentList,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = studentList[index];
                  return ListTile(
                    title: Text(data.name),
                    leading: CircleAvatar(
                      backgroundImage: MemoryImage(
                          const Base64Decoder().convert(data.image)),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          final currentIndex = index + 1;
                          deleteStudentAlert(context, currentIndex);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
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
                itemCount: studentList.length);
          }),
    );
  }

  void deleteStudentAlert(BuildContext context, int id) async {
    showDialog(
        context: context,
        builder: (context1) {
          return AlertDialog(
            title: const Text('Are you sure want to delete ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    DBFunctions.instance.deleteStudent(id);
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
        });
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
