import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:private_store_admin/data/models/app_info_model.dart';
import 'package:private_store_admin/presentation/screens/detail/app_detail_screen.dart';

class AppListItem extends StatelessWidget {
  final AppInfoModel appInfoModel;

  const AppListItem({Key? key, required this.appInfoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppDetailScreen(
                      appInfoModel: appInfoModel,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Text(appInfoModel.appName),
            ),
            Flexible(flex: 1, fit: FlexFit.tight, child: Text(appInfoModel.os)),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(appInfoModel.releaseType)),
            Flexible(
                flex: 2, fit: FlexFit.tight, child: Text(appInfoModel.version)),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(appInfoModel.updateDate)),
          ],
        ),
      ),
    );
  }
}
