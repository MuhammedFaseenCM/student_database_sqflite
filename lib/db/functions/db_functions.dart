import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

class DBFunctions extends ChangeNotifier {
  static final DBFunctions instance = DBFunctions._internal();

  DBFunctions._internal() {
    initializeDataBase();
  }
  late Database _db;
  Future<void> initializeDataBase() async {
    _db = await openDatabase(
      'student.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, place TEXT, phone TEXT, imagePath TEXT)');
      },
    );
  }

  Future<void> addStudent(StudentModel value) async {
    await _db.rawInsert(
        'INSERT INTO student (name,age,place,phone,imagePath) VALUES (?,?,?,?,?)',
        [value.name, value.age, value.place, value.phone, value.imagePath]);
    getAllStudents();
  }

  Future<void> getAllStudents() async {
    final values = await _db.rawQuery('SELECT * FROM student');
    studentListNotifier.value.clear();
    if (values.isEmpty) {
      studentListNotifier.value = [];
    } else {
      for (var map in values) {
        final student = StudentModel.fromMap(map);
        studentListNotifier.value.add(student);
        studentListNotifier.notifyListeners();
      }
    }
    studentListNotifier.notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
    getAllStudents();
  }

  Future<void> updateStudent({required StudentModel value}) async {
    await _db.rawUpdate(
        'UPDATE student SET name = ?, age = ?, place = ?, phone = ?, imagePath = ? WHERE id = ?',
        [
          value.name,
          value.age,
          value.place,
          value.phone,
          value.imagePath,
          (value.id! + 1)
        ]);
    getAllStudents();
  }
}
