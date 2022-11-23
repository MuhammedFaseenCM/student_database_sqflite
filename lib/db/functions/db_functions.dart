import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/data_model.dart';

ValueNotifier<List<StudentModel>> studentlistNotifier = ValueNotifier([]);
late Database _db;
Future<void> initializeDataBase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, place TEXT, phone TEXT, image TEXT)');
    },
  );
}

Future<void> addStudent(StudentModel value) async {
  // final studentDB = await Hive.openBox<StudentModel>('student_db');
  //final id = await studentDB.add(value);
  //value.id = id;
  await _db.rawInsert(
      'INSERT INTO student (name,age,place,phone,image) VALUES (?,?,?,?,?)',
      [value.name, value.age, value.place, value.phone, value.image]);
  getAllStudents();
  // studentlistNotifier.value.add(value);
  // studentlistNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  // final studentDB = await Hive.openBox<StudentModel>('student_db');
  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);
  studentlistNotifier.value.clear();
  _values.forEach((map) {
    final student = StudentModel.fromMap(map);
    studentlistNotifier.value.add(student);
    studentlistNotifier.notifyListeners();
  });
}

Future<void> deleteStudent(int id) async {
  await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
  getAllStudents();
}

Future<void> updateStudent(
    {required String name,
    required String age,
    required String place,
    required String phone,
    required String image,
    required int id}) async {
  await _db.rawUpdate(
      'UPDATE student SET name = ?, age = ?, place = ?, phone = ?, image = ? WHERE id = ?',
      [name, age, place, phone, image, id]);
  getAllStudents();
}
