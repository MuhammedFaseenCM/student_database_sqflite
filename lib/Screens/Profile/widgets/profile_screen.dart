import 'dart:io';
import 'package:flutter/material.dart';
import '../../../db/model/data_model.dart';
import 'edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  final StudentModel data;
  final int index;
  const ProfileScreen({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(
                    File(
                      data.imagePath,
                    ),
                  ),
                ),
                Text(
                  data.name,
                  style: const TextStyle(fontSize: 50),
                ),
                Text(
                  'Age: ${data.age}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Place: ${data.place}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'phone: ${data.phone}',
                  style: const TextStyle(fontSize: 20),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditScreen(
                          data: data,
                          index: index,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Update details'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
