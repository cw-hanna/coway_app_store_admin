import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:private_store_admin/data/models/app_info_model.dart';

class AppDetailScreen extends StatefulWidget {
  final AppInfoModel appInfoModel;
  const AppDetailScreen({Key? key, required this.appInfoModel}) : super(key: key);

  @override
  State<AppDetailScreen> createState() => _AppDetailScreenState();
}

class _AppDetailScreenState extends State<AppDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
    
  }
}