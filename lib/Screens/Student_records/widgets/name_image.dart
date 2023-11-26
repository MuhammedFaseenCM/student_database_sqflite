import 'dart:convert';

import 'package:flutter/material.dart';

class NameImage extends StatelessWidget {
  final String name;
  final String image;
  const NameImage({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(name),
          Image(image: MemoryImage(const Base64Decoder().convert(image)))
        ],
      ),
    );
  }
}
