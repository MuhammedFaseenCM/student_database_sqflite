import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_database/db/functions/db_functions.dart';
import 'package:student_database/db/model/dart_model.dart';

class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({super.key});
  final _namecontrol = TextEditingController();
  final _agecontrol = TextEditingController();
  final _placecontrol = TextEditingController();
  final _phonecontrol = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _namecontrol,
            decoration: InputDecoration(
              hintText: 'Full name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _agecontrol,
            decoration: InputDecoration(
              hintText: 'Age',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _placecontrol,
            decoration: InputDecoration(
              hintText: 'Place',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _phonecontrol,
            decoration: InputDecoration(
              hintText: 'Phone number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
              onPressed: () {
                AddButton();
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Student'))
        ]),
      ),
    );
  }

  Future<void> AddButton() async {
    final _name = _namecontrol.text;
    final _age = _agecontrol.text;
    final _place = _placecontrol.text;
    final _phone = _phonecontrol.text;

    if (_name.isEmpty || _age.isEmpty || _place.isEmpty || _phone.isEmpty) {
      return;
    }

    final student =
        StudentModel(name: _name, age: _age, place: _place, phone: _phone);
    addStudent(student);
  }
}
