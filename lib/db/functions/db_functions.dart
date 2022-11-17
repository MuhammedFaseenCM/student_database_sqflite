import 'package:flutter/cupertino.dart';

import '../model/dart_model.dart';

ValueNotifier<List<StudentModel>> studentlistNotifier = ValueNotifier([]);

void addStudent(StudentModel value) {
  studentlistNotifier.value.add(value);
  studentlistNotifier.notifyListeners();
}
