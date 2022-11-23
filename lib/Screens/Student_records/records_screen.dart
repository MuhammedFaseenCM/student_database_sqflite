import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_database/Screens/Student_records/widgets/name_image.dart';
import 'package:student_database/Screens/Student_records/widgets/profile.dart';
import 'package:student_database/Screens/home/home_screen.dart';
import 'package:student_database/db/functions/db_functions.dart';
import 'package:student_database/db/model/data_model.dart';

class record_screen extends StatefulWidget {
  StudentModel data;
  int? index;
  record_screen({super.key, required this.data, required this.index});

  @override
  State<record_screen> createState() => _record_screenState();
}

class _record_screenState extends State<record_screen> {
  int _currentselectedIndex = 0;
  late StudentModel data;
  // final name = data.name;

  final _pages = [
    const Profile_student(),
    // Name_image(name: data.name, image: data.image)
  ];
  //  Name_image(name: data.name)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentselectedIndex],
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              exitformprofoile(context);
            },
            icon: Icon(Icons.exit_to_app))
      ]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentselectedIndex,
          onTap: (newindex) {
            setState(() {
              _currentselectedIndex = newindex;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home')
          ]),
    );
  }

  void exitformprofoile(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            title: Text('Are you sure want to exit ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx1)
                        .pushReplacement(MaterialPageRoute(builder: (ctx2) {
                      return Home_screen();
                    }));
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx1).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }
}
