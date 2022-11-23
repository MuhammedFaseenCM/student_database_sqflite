import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../db/model/data_model.dart';
import 'edit_screen.dart';

class Profile_screen extends StatelessWidget {
  StudentModel data;

  int? index;

  final _name = TextEditingController();
  final _age = TextEditingController();
  final _domain = TextEditingController();
  final _phone = TextEditingController();
  Profile_screen({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        MemoryImage(const Base64Decoder().convert(data.image)),
                  ),
                  Text(
                    data.name,
                    style: const TextStyle(fontSize: 50),
                  ),
                  Text(
                    'Age: ' + data.age,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Place: ' + data.place,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'phone: ' + data.phone,
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditScreen(
                                  data: data,
                                  index: index,
                                )));
                      },
                      icon: Icon(Icons.edit),
                      label: Text('Update details'))
                ],
              ),
            ),
          ),
        ));
  }
}
