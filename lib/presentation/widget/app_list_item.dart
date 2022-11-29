import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppListItem extends StatelessWidget {
  final String appName;
  final String os;
  final String releaseType;
  final String role;
  final String owner;

  const AppListItem(
      {Key? key,
      required this.appName,
      required this.os,
      required this.releaseType,
      required this.role,
      required this.owner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Text(appName),
          ),
          Flexible(flex: 1, fit: FlexFit.tight, child: Text(os)),
          Flexible(flex: 2, fit: FlexFit.tight, child: Text(releaseType)),
          Flexible(flex: 2, fit: FlexFit.tight, child: Text(role)),
          Flexible(flex: 2, fit: FlexFit.tight, child: Text(owner))
        ],
      ),
    );
  }
}
