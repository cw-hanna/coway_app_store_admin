import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:private_store_admin/presentation/blocs/login_bloc.dart';
import 'package:private_store_admin/presentation/screens/login/login_screen.dart';
import 'package:private_store_admin/presentation/screens/main/main_screen.dart';
import 'package:private_store_admin/presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainScreen()
          //SplashScreen()
          ),
    );
  }
}
