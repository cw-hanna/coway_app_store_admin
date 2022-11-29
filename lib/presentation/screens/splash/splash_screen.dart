import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:private_store_admin/presentation/blocs/login_bloc.dart';
import 'package:private_store_admin/presentation/screens/login/login_screen.dart';
import 'package:private_store_admin/presentation/screens/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _login(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccess) {
                  return MainScreen();
                }
                return LoginScreen();
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future _login() async {
    /**
     * 쿠키를 이용한 로그인 수행
     */
    return true;
  }
}
