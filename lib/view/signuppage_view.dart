import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/login_bloc/login_bloc.dart';
import 'package:todo_app/bloc/login_bloc/login_event.dart';
import 'package:todo_app/bloc/login_bloc/login_state.dart';
import 'package:todo_app/bloc/signup_bloc.dart/signup_bloc.dart';
import 'package:todo_app/bloc/signup_bloc.dart/signup_event.dart';
import 'package:todo_app/bloc/signup_bloc.dart/signup_state.dart';
import 'package:todo_app/utils/storage_services.dart';
import 'package:todo_app/view/loginpage_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // PlatformFile? pickedFile;
  // UploadTask? uploadTask;

  // Future uploadFile() async {
  //   final path = 'profile/${pickedFile!.name}';
  //   final file = File(pickedFile!.path!);

  //   uploadTask = FirebaseStorage.instance
  //       .ref('profile/${pickedFile!.name}')
  //       .putFile(file);
  //   // uploadTask = ref

  //   final snapshot = await uploadTask!.whenComplete(() {});
  //   final imageUrl = await snapshot.ref.getDownloadURL();
  //   print(imageUrl);
  // }

  // Future selectFile() async {
  //   final image = await FilePicker.platform
  //       .pickFiles(allowMultiple: false, type: FileType.image);
  //   // if (image == null) {
  //   //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No file selected")));
  //   // }
  //   // return null;
  //   setState(() {
  //     pickedFile = image!.files.first;
  //   });
  // }

  final TextEditingController _newemailController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _newusernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //   final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          if (state is SignupInitialState) {
            print('asdasdh${state.path}');
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.path != '')
                        Expanded(
                            // child: InkWell(
                            //   child: CircleAvatar(
                            //     radius: 100,
                            //     backgroundImage: state.path != '' ? Image.file(
                            //   File(state.path))
                            //   : Icon(Icons.access_time)
                            //   ),
                            // ),
                            child: Container(
                          child: Image.file(
                            File(state.path),
                            width: double.infinity,
                            // height: 100,
                            fit: BoxFit.cover,
                          ),
                        )),
                      FloatingActionButton(
                        onPressed: () {
                          BlocProvider.of<SignupBloc>(context)
                              .add(ImagePickerEvent());
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          size: 20,
                        ),
                      ),
                      TextFormField(
                        controller: _newusernameController,
                        decoration: const InputDecoration(
                          hintText: "Enter Username",
                          errorStyle: TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _newemailController,
                        decoration: const InputDecoration(
                          hintText: "Enter Email",
                          errorStyle: TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          } else if (!value.contains('@')) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _newpasswordController,
                        decoration: const InputDecoration(
                          hintText: "Enter Password",
                          errorStyle: TextStyle(color: Colors.redAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // setState(() {
                            //   uploadFile(state.path, _newemailController.text);
                            // });
                            BlocProvider.of<SignupBloc>(context).add(
                                SignupSuccessEvent(
                                    _newemailController.text,
                                    _newpasswordController.text,
                                    _newusernameController.text,
                                    state.path));
                          },
                          child: const Text("SignUp")),
                      Row(
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("Login",
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline)))
                        ],
                      )
                    ]),
              ),
            );
          } else if (state is SignupSuccessState) {
            Navigator.of(context).pop();
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
