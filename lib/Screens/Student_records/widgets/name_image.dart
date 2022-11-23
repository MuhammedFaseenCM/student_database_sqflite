import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_database/db/model/data_model.dart';

class Name_image extends StatelessWidget {
  final String name;
  final String image;
  const Name_image({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(name),
          Image(image: MemoryImage(Base64Decoder().convert(image)))
        ],
      ),
    );
  }
}
