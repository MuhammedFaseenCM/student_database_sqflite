import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/db/functions/db_functions.dart';
import 'package:student_database/db/model/data_model.dart';

class AddStudentWidget extends StatefulWidget {
  AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _namecontrol = TextEditingController();

  final _agecontrol = TextEditingController();

  final _placecontrol = TextEditingController();

  final _phonecontrol = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  String _picture = '';

  String _pictureToString = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          imageProfile(),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _namecontrol,
            decoration: const InputDecoration(
              hintText: 'Full name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter full name';
              } else if (value.length < 3) {
                return 'Name must be atleast 3 character';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _agecontrol,
            decoration: const InputDecoration(
              hintText: 'Age',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your age';
              } else if (value.length > 2) {
                return 'Enter a valid age';
              } else {
                return null;
              }
            },
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your place';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
              controller: _phonecontrol,
              decoration: const InputDecoration(
                hintText: 'Phone number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Phone number';
                } else if (value.length < 10) {
                  return 'Enter a valid phone number';
                } else {
                  return null;
                }
              }),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  AddButton();
                  showsnackbar();
                } else {
                  print('Empty');
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Student'))
        ]),
      ),
    );
  }

  Future<void> AddButton() async {
    final _name = _namecontrol.text.trim();
    final _age = _agecontrol.text.trim();
    final _place = _placecontrol.text.trim();
    final _phone = _phonecontrol.text.trim();
    final _image = _pictureToString;

    if (_name.isEmpty ||
        _age.isEmpty ||
        _place.isEmpty ||
        _phone.isEmpty ||
        _image.isEmpty) {
      return;
    }

    final student = StudentModel(
        name: _name, age: _age, place: _place, phone: _phone, image: _image);
    addStudent(student);
    getAllStudents();
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose your photo',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    acceptImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery')),
              TextButton.icon(
                  onPressed: () {
                    acceptImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'))
            ],
          )
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                MemoryImage(const Base64Decoder().convert(_picture)),
          ),
          Positioned(
              child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomsheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              size: 30,
            ),
          ))
        ],
      ),
    );
  }

  acceptImage(ImageSource source) async {
    final recieveImage = await _picker.pickImage(source: source);
    if (recieveImage == null) {
      return;
    } else {
      final picturetemp = File(recieveImage.path).readAsBytesSync();
      setState(() {
        _pictureToString = base64Encode(picturetemp);
        _picture = _pictureToString;
      });
      Navigator.of(context).pop();
    }
  }

  showsnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Succesfully added'),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      backgroundColor: Colors.green,
    ));
  }
}
