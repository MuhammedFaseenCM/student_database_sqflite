import 'package:flutter/material.dart';
import 'package:student_database/Screens/home/home_screen.dart';
import 'package:student_database/db/functions/db_functions.dart';
import 'package:student_database/db/model/data_model.dart';

import 'Screens/home/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDataBase();
  runApp(Student_App());
}

class Student_App extends StatelessWidget {
  const Student_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Splash_Screen(),
    );
  }
}
