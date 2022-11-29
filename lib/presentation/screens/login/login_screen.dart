import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:private_store_admin/config/theme/cw_colors.dart';
import 'package:private_store_admin/presentation/blocs/login_bloc.dart';

///LoginScreen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loginScreen(idController, pwdController, context);
  }
}

//로그인 요청화면(로그아웃된 상태)
Widget loginScreen(TextEditingController idController,
    TextEditingController pwdController, BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      color: Colors.white,
      child: Column(
        children: [
          TextFormField(
            controller: idController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'ID',
              hintStyle: TextStyle(
                fontSize: 20,
                color: CwColors.darkGray,
              ),
              filled: true,
              fillColor: CwColors.gray,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: pwdController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: 'PASSWORD',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: CwColors.darkGray,
                ),
                filled: true,
                fillColor: CwColors.gray,
                border: InputBorder.none),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<LoginBloc>(context).add(LoginRequested(
                  id: idController.text, pwd: pwdController.text));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  color: CwColors.color2),
              child: const Center(
                child: Text('로그인'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
