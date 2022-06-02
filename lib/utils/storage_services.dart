import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

Future uploadFile(String filePath, String fileName) async {
  File file = File(filePath);
  try {
    final ref = FirebaseStorage.instance.ref('profile/$fileName');
    UploadTask uploadTask = ref.putFile(file);
    print('done');

    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();
    print('Download link - $imageUrl');
    return imageUrl;
  } on FirebaseException catch (e) {
    print(e);
  }
}

Future selectFile() async {
  final image = await FilePicker.platform
      .pickFiles(allowMultiple: false, type: FileType.image);
  // if (image == null) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No file selected")));
  // }
  // return null;

  //pickedFile = image!.files.first;

  final path = image!.files.single.path;
  final fileName = image.files.single.name;
  print(path);

  return path;
}
