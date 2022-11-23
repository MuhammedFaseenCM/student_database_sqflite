import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/Screens/Profile/widgets/profile_screen.dart';
import 'package:student_database/Screens/home/widgets/list_student_widget.dart';
import '../../../db/functions/db_functions.dart';
import '../../../db/model/data_model.dart';

class EditScreen extends StatefulWidget {
  StudentModel data;

  int? index;

  EditScreen({super.key, required this.data, required this.index});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  String _picture = '';

  String _pictureToString = '';

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.data.name.toString();
    _ageController.text = widget.data.age.toString();
    _placeController.text = widget.data.place.toString();
    _phoneController.text = widget.data.phone.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit details'),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
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
                controller: _nameController,
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
                controller: _ageController,
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
                controller: _placeController,
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
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Phone number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Phone number';
                    } else if (value.length != 10) {
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
                      updateButton();
                    } else {
                      print('Empty');
                      print(widget.index! + 1);
                    }
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Update Student'))
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> updateButton() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final place = _placeController.text.trim();
    final phone = _phoneController.text.trim();
    final image = _pictureToString;

    if (name.isEmpty ||
        age.isEmpty ||
        place.isEmpty ||
        phone.isEmpty ||
        image.isEmpty) {
      return;
    } else {
      final indx = widget.index! + 1;

      updateStudent(
          name: name,
          age: age,
          place: place,
          phone: phone,
          image: image,
          id: indx);
      getAllStudents();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ListStudentWidget()));
    }
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
                  icon: Icon(Icons.image),
                  label: Text('Gallery')),
              TextButton.icon(
                  onPressed: () {
                    acceptImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera'))
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
            child: Icon(
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
}
