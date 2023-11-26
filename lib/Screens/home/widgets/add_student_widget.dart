import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/db/functions/db_functions.dart';
import 'package:student_database/db/model/data_model.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameControl = TextEditingController();

  final _ageControl = TextEditingController();

  final _placeControl = TextEditingController();

  final _phoneControl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  String _picture = '';

  String _pictureToString = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
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
            controller: _nameControl,
            decoration: const InputDecoration(
              hintText: 'Full name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter full name';
              } else if (value.length < 3) {
                return 'Name must be at least 3 character';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _ageControl,
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
            controller: _placeControl,
            decoration: const InputDecoration(
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
              controller: _phoneControl,
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
                  addButton();
                  showSnackbar();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Student'))
        ]),
      ),
    );
  }

  Future<void> addButton() async {
    final name = _nameControl.text.trim();
    final age = _ageControl.text.trim();
    final place = _placeControl.text.trim();
    final phone = _phoneControl.text.trim();
    final image = _pictureToString;

    if (name.isEmpty ||
        age.isEmpty ||
        place.isEmpty ||
        phone.isEmpty ||
        image.isEmpty) {
      return;
    }

    final student = StudentModel(
        name: name, age: age, place: place, phone: phone, image: image);
    DBFunctions.instance.addStudent(student);
    DBFunctions.instance.getAllStudents();
  }

  Widget bottomSheet() {
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
                    acceptImage(ImageSource.gallery, context);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery')),
              TextButton.icon(
                  onPressed: () {
                    acceptImage(ImageSource.camera, context);
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
                builder: ((builder) => bottomSheet()),
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

  acceptImage(ImageSource source, context) async {
    final receiveImage = await _picker.pickImage(source: source);
    if (receiveImage == null) {
      return;
    } else {
      final pictureTemp = File(receiveImage.path).readAsBytesSync();
      setState(() {
        _pictureToString = base64Encode(pictureTemp);
        _picture = _pictureToString;
      });
      Navigator.of(context).pop();
    }
  }

  showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully added'),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      backgroundColor: Colors.green,
    ));
  }
}
