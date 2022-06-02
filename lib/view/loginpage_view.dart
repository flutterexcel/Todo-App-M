import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/bloc/login_bloc/login_bloc.dart';
import 'package:todo_app/bloc/login_bloc/login_event.dart';
import 'package:todo_app/bloc/login_bloc/login_state.dart';
import 'package:todo_app/bloc/signup_bloc.dart/signup_bloc.dart';
import 'package:todo_app/bloc/signup_bloc.dart/signup_event.dart';
import 'package:todo_app/utils/google_authentication.dart';
import 'package:todo_app/utils/routes.dart';
import 'package:todo_app/view/homepage_view.dart';
import 'package:todo_app/view/signuppage_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(LoginInitialEvent());
    print("Login");
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginInitialState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo app'),
            backgroundColor: const Color(0xFFAF7AC5),
          ),
          body: SingleChildScrollView(
            child: Container(
              // decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage("assets/images/todo_back.jpg"),
              //         fit: BoxFit.fill)),
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                      height: 230,
                      width: 250,
                      child: Image.asset("assets/images/todo.png")),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0),
                    child: Container(
                      child: Column(children: [
                        TextFormField(
                          autofocus: false,
                          controller: _emailController,
                          decoration: const InputDecoration(
                              hintText: "Enter Email",
                              label: Text("Email"),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(color: Colors.redAccent)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            } else if (!value.contains('@')) {
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              hintText: "Enter Password",
                              label: Text("Password"),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(color: Colors.redAccent)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        const TextButton(
                            onPressed: null,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginUserEvent(_emailController.text,
                                      _passwordController.text));
                            },
                            child: Text("Login")),
                        Row(
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()));
                                },
                                child: Text("Signup",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline)))
                          ],
                        )
                      ]),
                    ),
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(60),
                    color: const Color(0xFFAF7AC5),
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(GoogleLoginSuccessEvent());
                        },
                        // async {
                        //   setState(() {
                        //     _isProcessing = true;
                        //   });
                        //   await signInWithGoogle().then((result) {
                        //     //  print(result);
                        //     if (result != null) {
                        //       //  Navigator.of(context).pop();
                        //       Navigator.of(context).pushReplacement(
                        //         MaterialPageRoute(
                        //           fullscreenDialog: true,
                        //           builder: (context) => HomePage(
                        //             user: result,
                        //           ),
                        //         ),
                        //       );
                        //     }
                        //   }).catchError((error) {
                        //     print('Registration Error: $error');
                        //   });
                        //   setState(() {
                        //     _isProcessing = false;
                        //   });
                        // },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: 220,
                          height: 40,
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Row(
                              children: [
                                Image.asset("assets/images/google_logo.png",
                                    height: 25.0),
                                const Text(" Sign in with Google",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFFFFFFFF))),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              )),
            ),
          ),
        );
      } else if (state is GoogleLoginSuccessState) {
        print('${state.users!.uid}');
        if (state.users != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => HomePage(
                  user: state.users!,
                ),
              ),
            );
          });
        }
      } else if (state is LoginUserState) {
        if (state.user != null) {
          Fluttertoast.showToast(
              msg: 'User login successful',
              backgroundColor: const Color.fromARGB(255, 76, 175, 80),
              gravity: ToastGravity.CENTER);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => HomePage(
                  user: state.user,
                ),
              ),
            );
          });
        }
      }
      return CircularProgressIndicator();
    });
  }
}
