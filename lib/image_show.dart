import 'dart:io';

import 'package:flutter/material.dart';
class imae_show extends StatelessWidget {
  File file;
   imae_show({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        height: 500,
        width: 500,
        child: Image.file(file) ,
      ),
    );
  }
}