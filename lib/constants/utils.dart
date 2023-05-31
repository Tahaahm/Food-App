// ignore_for_file: unused_local_variable, avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImage() async {
  List<File> images = [];

  try {
    var file = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (file != null && file.files.isNotEmpty) {
      for (int i = 0; i < file.files.length; i++) {
        images.add(
          File(file.files[i].path!),
        );
      }
    }
  } catch (e) {
    print(e);
  }
  return images;
}
