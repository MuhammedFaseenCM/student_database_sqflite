import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/Screens/home/widgets/list_student_widget.dart';
import 'package:student_database/db/functions/db_functions.dart';
import 'package:student_database/db/model/data_model.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _placeController = TextEditingController();

  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          const SizedBox(
            height: 20,
          ),
          imageProfile(),
          _imageToString == ''
              ? const Text(
                  'select your image',
                  style: TextStyle(color: Colors.red),
                )
              : const SizedBox(),
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
              } else if (value.contains('12345678910')) {
                return 'Name must be in letters';
              } else if (value.length < 3) {
                return 'Name must be atleast 3 character';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
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
            height: 10,
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
            height: 10,
          ),
          TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
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
            height: 10,
          ),
          ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  onAddStudentButtonClicked();
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Successfully added'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ListStudentWidget(),
                                ),
                              );
                            },
                            child: const Text('Goto List'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Back'),
                          )
                        ],
                      );
                    },
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Student'))
        ]),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: [
        Container(
          height: 100,
          width: 100,
          decoration: _imageToString != ''
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(_imageToString))))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey,
                ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (builder) => bottomsheet(),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
        )
      ]),
    );
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
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery')),
              TextButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'))
            ],
          )
        ],
      ),
    );
  }

  String _imageToString = '';
  File imageTemp = File("");
  Future<void> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    } else {
      imageTemp = File(image.path);
      _imageToString = image.path;
      log(_imageToString);
      setState(() {
        //  _images = imageTemp;
        _imageToString = image.path;
        Navigator.of(context).pop();
      });
    }
  }

  Future<void> onAddStudentButtonClicked() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final place = _placeController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || age.isEmpty || place.isEmpty || phone.isEmpty) {
      return;
    } else {
      final student = StudentModel(
        name: name,
        age: age,
        place: place,
        phone: phone,
        imagePath: _imageToString,
      );
      DBFunctions.instance.addStudent(student);
    }
  }
}
