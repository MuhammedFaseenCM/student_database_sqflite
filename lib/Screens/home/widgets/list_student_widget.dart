import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          valueListenable: studentlistNotifier,
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
                          // if (data.id != null) {
                          final indx = index + 1;
                          deleteStudentAlert(context, indx);

                          // } else {
                          //   print('student id is null');
                          // }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Profile_screen(data: data, index: index)));
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
            title: Text('Are you sure want to delete ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteStudent(id);
                    Navigator.of(context).pop();
                    showsnackbar();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }

  showsnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Deleted succesfully'),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      backgroundColor: Colors.green,
    ));
  }
}
