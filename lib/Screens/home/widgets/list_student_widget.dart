import 'dart:io';
import 'package:flutter/material.dart';
import '../../../db/functions/db_functions.dart';
import '../../../db/model/data_model.dart';
import '../../Profile/widgets/profile_screen.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<StudentModel> searchedStudent = [];

  @override
  void initState() {
    DBFunctions.instance.getAllStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          if (studentList.isEmpty) {
            return const Center(
              child: Text(
                "Student list is empty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          if (isSearching &&
              searchController.text.isNotEmpty &&
              searchedStudent.isEmpty) {
            return const Center(
              child: Text(
                "No student found",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (_, index) {
              final StudentModel data;
              if (isSearching &&
                  searchedStudent.isNotEmpty &&
                  searchController.text.isNotEmpty) {
                data = searchedStudent[index];
              } else {
                data = studentList[index];
              }
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(data: data, index: index),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(
                            File(data.imagePath),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            data.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteStudentAlert(context, data.id!);
                          },
                          color: Colors.red,
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: isSearching && searchController.text.isNotEmpty
                ? searchedStudent.length
                : studentList.length,
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: isSearching
          ? TextFormField(
              controller: searchController,
              onChanged: (value) {
                searchedStudent.clear();
                for (var element in studentListNotifier.value) {
                  if (element.name
                      .toLowerCase()
                      .contains(value.toLowerCase())) {
                    searchedStudent.add(element);
                  }
                }
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            )
          : const Text('Student list'),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
            });
          },
          icon:
              isSearching ? const Icon(Icons.close) : const Icon(Icons.search),
        )
      ],
    );
  }

  Future<void> deleteStudentAlert(context, int id) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Are you sure want to delete ?'),
          actions: [
            TextButton(
                onPressed: () async {
                  await DBFunctions.instance.deleteStudent(id);
                  Navigator.of(context).pop();
                  showSnackbar();
                },
                child: const Text('Yes')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            )
          ],
        );
      },
    );
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deleted successfully'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
      ),
    );
  }
}
