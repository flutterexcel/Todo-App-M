import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/home_bloc/home_bloc.dart';
import 'package:todo_app/bloc/home_bloc/home_event.dart';
import 'package:todo_app/bloc/home_bloc/home_state.dart';
import 'package:todo_app/bloc/login_bloc/login_state.dart';
import 'package:todo_app/utils/google_authentication.dart';
import 'package:todo_app/view/chart_view.dart';
import 'package:todo_app/view/loginpage_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User _user;
  bool _isSigningOut = false;
  List<String> todoList = [];
  TextEditingController taskController = TextEditingController();
  String category = 'Personal';
  List<String> categoryList = ["Personal", "Work", "School", "Home"];

  // DateTime taskEndDate = DateTime.now();
  // HomeBloc homebloc = HomeBloc();
  //bool apiData = false;

  @override
  void initState() {
    _user = widget._user;
    // getHomeDetails();

    super.initState();
  }

  // Future getHomeDetails() async {
  //   await homebloc.allGetData().then((value) {
  //     if (value != null) {
  //       apiData = true;
  //     }
  //   });
  // }

  // dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Welcome")),
          actions: [
            PopupMenuButton(
              tooltip: _user.displayName,
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Row(children: [
                  Icon(
                    Icons.person,
                    color: Color(0xFF000000),
                  ),
                  SizedBox(width: 10),
                  Text("${_user.displayName}")
                ])),
                PopupMenuItem(
                    onTap: () {
                      // setState(() {
                      //   _isSigningOut = true;
                      // });

                      BlocProvider.of<HomeBloc>(context)
                          .add(GoogleSignOutEvent(context));
                      // final GoogleSignIn googleSignIn = GoogleSignIn();
                      // SharedPreferences prefs = await SharedPreferences.getInstance();

                      // try {
                      //   print("sighnout");
                      //   // if (!kIsWeb) {
                      //   await FirebaseAuth.instance.signOut();
                      //   // prefs.clear();
                      //   // }
                      //   print("sighnout2");
                      //   await googleSignIn.signOut();
                      //   print("sighnout3");
                      //   Navigator.pushReplacement(context,
                      //       MaterialPageRoute(builder: (_) => LoginPage()));
                      // } catch (e) {
                      //   print('Error occurred while logging out. Try again.');
                      // }

                      // setState(() {
                      //   _isSigningOut = false;
                      // });
                    },
                    child: Row(children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Color(0xFF000000),
                      ),
                      SizedBox(width: 10),
                      Text("Sign out")
                    ]),
                    value: 1),
              ],
              child: _user.photoURL != null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipOval(
                        child: Material(
                          child: Image.network(
                            _user.photoURL!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : const ClipOval(
                      child: Material(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.person,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 05),
              child: Container(
                height: 45,
                child: ListView(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Material(
                        color: Colors.white38,
                        borderOnForeground: true,
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(60),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(AllTaskEvent());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: const Text(
                              "All tasks",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Material(
                        color: Colors.white38,
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(60),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(PersonalTaskEvent('Personal'));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: const Text(
                              "Personal",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Material(
                        color: Colors.white38,
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(60),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(WorkTaskEvent('Work'));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: const Text(
                              "Work",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Material(
                        color: Colors.white38,
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(60),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(SchoolTaskEvent('School'));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: const Text(
                              "School",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Material(
                        color: Colors.white38,
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(60),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(PersonalTaskEvent('Home'));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: const Text(
                              "Home",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeInitialState) {
                print("initial state");
                BlocProvider.of<HomeBloc>(context).add(AllTaskEvent());
              } else if (state is CategoryTaskState) {
                print("category state");
                return Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: ListView.builder(
                        itemCount: state.dont.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Color(0xFF121211),
                                borderRadius: BorderRadius.circular(10)),
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            state.dont[index]['title'],
                                            style: TextStyle(fontSize: 20),
                                          )),
                                      Container(
                                          margin: EdgeInsets.only(left: 10),
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Text(
                                              state.dont[index]['category']))
                                    ]),
                                Container(
                                    child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(uid)
                                        .collection('mytasks')
                                        .doc(state.dont[index]['time'])
                                        .delete();
                                    Fluttertoast.showToast(
                                        msg: 'Task deleted',
                                        backgroundColor: const Color.fromARGB(
                                            255, 76, 175, 80),
                                        gravity: ToastGravity.CENTER);
                                    BlocProvider.of<HomeBloc>(context)
                                        .add(AllTaskEvent());
                                  },
                                ))
                              ],
                            ),
                          );
                        }));
              } else if (state is GoogleSignOutState) {
                print("Logout state");
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     fullscreenDialog: true,
                //     builder: (context) => LoginPage(),
                //   ),
                // );
                // });
                Fluttertoast.showToast(
                    msg: 'Logout successful',
                    backgroundColor: const Color.fromARGB(255, 76, 175, 80),
                    gravity: ToastGravity.CENTER);

                // return LoginPage();
              }
              return const SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator());
            }
                //   return CircularProgressIndicator();
                // },
                )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF127DA7),
          onPressed: () {
            showAlertDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ElevatedButton(
                  onPressed: null,
                  child: Icon(Icons.fact_check_outlined, color: Colors.white)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Charts()));
                  },
                  child: const Icon(Icons.done, color: Colors.white))
            ],
          ),
          color: const Color(0xFF000000),
          // height: 55,
          // width: MediaQuery.of(context).size.width
        ));
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("ADD TASK"),
      onPressed: () {
        addtasktofirebase();
        taskController.clear();
        Navigator.of(context).pop();
        BlocProvider.of<HomeBloc>(context).add(AllTaskEvent());
      },
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text("Add a new task "),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: true,
                  controller: taskController,
                  decoration: const InputDecoration(hintText: "Enter Task"),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                    hint: const Text("Category"),
                    value: category,
                    items: categoryList.map((String e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        category = newValue!;
                      });
                    }),
              ],
            ),
            actions: [
              okButton,
            ],
          );
        });
      },
    );
  }

  addtasktofirebase() async {
    String uid = _user.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
      'title': taskController.text,
      'category': category,
      'time': time.toString(),
      'timestamp': time,
      //'taskenddate': taskEndDate
    });
    Fluttertoast.showToast(msg: 'Task added');
    BlocProvider.of<HomeBloc>(context).add(AllTaskEvent());
  }
}
