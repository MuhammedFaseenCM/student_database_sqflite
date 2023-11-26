import 'package:flutter/material.dart';
import 'package:student_database/Screens/Student_records/widgets/profile.dart';
import 'package:student_database/Screens/home/home_screen.dart';
import 'package:student_database/db/model/data_model.dart';

class RecordScreen extends StatefulWidget {
  final StudentModel data;
  final int? index;
const RecordScreen({super.key, required this.data, required this.index});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  int _currentSelectedIndex = 0;
  late StudentModel data;
  // final name = data.name;

  final _pages = [
    const ProfileStudent(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentSelectedIndex],
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              exitFromProfile(context);
            },
            icon: const Icon(Icons.exit_to_app))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home')
        ],
      ),
    );
  }

  void exitFromProfile(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          title: const Text('Are you sure want to exit ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx1).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx2) {
                        return const HomeScreen();
                      },
                    ),
                  );
                },
                child: const Text('Yes')),
            TextButton(
              onPressed: () {
                Navigator.of(ctx1).pop();
              },
              child: const Text('No'),
            )
          ],
        );
      },
    );
  }
}
