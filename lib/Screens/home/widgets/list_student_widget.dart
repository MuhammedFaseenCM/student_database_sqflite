import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_database/db/functions/db_functions.dart';

import '../../../db/model/dart_model.dart';

class ListStudentWidget extends StatelessWidget {
  ListStudentWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentlistNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentlist, Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentlist[index];
            return ListTile(
              title: Text(data.name),
              subtitle: Text(data.age + '\n' + data.phone + '\n' + data.place),
            );
          },
          separatorBuilder: ((context, index) => Divider()),
          itemCount: studentlist.length,
        );
      },
    );
  }
}
