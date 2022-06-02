import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// String? uid;
// String? name;
// String? userEmail;
// String? imageUrl;

Future<void> newUserRegister(
    String email, String password, String username, String imgUrl) async {
  //User? user = await FirebaseAuth.instance.currentUser;

  UserCredential users = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);
  await users.user!.updateDisplayName(username);
  await users.user!.updatePhotoURL(imgUrl);

//   print(users);
//   print('User email - ${users.user!.email}');
//  String userna = await users.user!.updateDisplayName(username);
//   .then((value) {
//     print('Photo URL updated - ${users.user!.displayName}');
//   });
//   await users.user!.updatePhotoURL(imgUrl);
//   .then((value) {
//     print('Username updated- ${users.user!.photoURL}');
//   });

  // FirebaseFirestore.instance
  //     .collection("Users")
  //     .doc(users.user!.uid)
  //     .set({'name': username, 'email': email, 'imageUrl': imgUrl}).then(
  //         (signedInUser) => {print('Signup success')});
  Fluttertoast.showToast(
      msg: 'User registration successful',
      backgroundColor: const Color.fromARGB(255, 76, 175, 80),
      gravity: ToastGravity.CENTER);
  print('User email - ${users.user!.email}');
  print('Photo URL updated - ${users.user!.displayName}');
  print('Username updated- ${users.user!.photoURL}');
}

Future userLogin(String email, String password) async {
  UserCredential users =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
  print('User email - ${users.user!.email}');
  print('Photo URL new - ${users.user!.displayName}');
  print('Username new- ${users.user!.photoURL}');
  return users.user;
}
