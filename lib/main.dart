import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/home_bloc/home_bloc.dart';
import 'package:todo_app/bloc/login_bloc/login_bloc.dart';
import 'package:todo_app/bloc/signup_bloc.dart/signup_bloc.dart';
import 'package:todo_app/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:todo_app/utils/routes.dart';
import 'package:todo_app/view/homepage_view.dart';
import 'package:todo_app/view/loginpage_view.dart';
import 'package:todo_app/view/transaction_view.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         "/": (context) => LoginPage(),
//         MyRoutes.homeRoute: (context) => HomePage(),
//         MyRoutes.loginRoute: (context) => LoginPage()
//       },
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
          BlocProvider<SignupBloc>(create: (context) => SignupBloc()),
          BlocProvider<TransactionBloc>(create: (context) => TransactionBloc()),
        ],
        child: MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.blue, brightness: Brightness.light),
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(brightness: Brightness.dark),
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
          // routes: {
          //   "/": (context) => const LoginPage(),
          //   MyRoutes.homeRoute: (context) => const HomePage(),
          //   MyRoutes.loginRoute: (context) => const LoginPage()
          // },
        ));
  }
}
