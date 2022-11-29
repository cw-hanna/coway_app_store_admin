import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainUserInfo extends StatelessWidget {
  final String userName;
  final String teamName;

  const MainUserInfo({Key? key, required this.userName, required this.teamName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Hello, $userName[$teamName]');
  }
}
