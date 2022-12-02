import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:private_store_admin/config/theme/cw_colors.dart';
import 'package:private_store_admin/data/models/app_info_model.dart';

class AppDetailScreen extends StatefulWidget {
  final AppInfoModel appInfoModel;
  const AppDetailScreen({Key? key, required this.appInfoModel})
      : super(key: key);

  @override
  State<AppDetailScreen> createState() => _AppDetailScreenState();
}

class _AppDetailScreenState extends State<AppDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Coway App Store'),
        backgroundColor: CwColors.color3,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '앱정보',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.w500),
            ),
            Text(
              widget.appInfoModel.appName,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Update Date : ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Text(widget.appInfoModel.updateDate,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900))
              ],
            ),
            Row(
              children: [
                Text(
                  'Version : ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Text(widget.appInfoModel.version,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900))
              ],
            ),
            Text(
              'Description : ' + widget.appInfoModel.description,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Container(
                  color: Colors.blueGrey,
                  padding: EdgeInsets.all(20),
                  child: Text('앱 다운로드'),
                ),
                Container(
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(20),
                  child: Text('새버전 출시'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
