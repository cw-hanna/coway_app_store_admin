import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:private_store_admin/config/theme/cw_colors.dart';
import 'package:private_store_admin/data/models/app_info_model.dart';
import 'package:private_store_admin/presentation/screens/detail/widgets/detail_app_upload_bottom_sheet.dart';
import 'package:cross_file/cross_file.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AppDetailScreen extends StatefulWidget {
  final AppInfoModel appInfoModel;
  const AppDetailScreen({Key? key, required this.appInfoModel})
      : super(key: key);

  @override
  State<AppDetailScreen> createState() => _AppDetailScreenState();
}

class _AppDetailScreenState extends State<AppDetailScreen> {
  XFile? _selectedFileDrag;
  PlatformFile? _selctedFileFind;

  bool _showQr = false;

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
              '앱이름 :' + widget.appInfoModel.appName,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '업데이트일 : ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Text(widget.appInfoModel.updateDate,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500))
              ],
            ),
            Row(
              children: [
                Text(
                  '버전 : ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Text(widget.appInfoModel.version,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500))
              ],
            ),
            Text(
              '앱 설명 : ' + widget.appInfoModel.description,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_selctedFileFind != null || _selectedFileDrag != null) {
                      setState(() {
                        _showQr = true;
                      });
                    }
                  },
                  child: Container(
                    color: Colors.blueGrey,
                    padding: EdgeInsets.all(20),
                    child: Text('앱 다운로드'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return DetailAppUploadBottomSheet(
                            dargUploadCallback: (file) {
                              //업로드한 파일 정보로 화면 update
                              setState(() {
                                _selectedFileDrag = file;
                              });
                            },
                            findUploadCallback: (file) {
                              //업로드한 파일 정보로 화면 update
                              setState(() {
                                _selctedFileFind = file;
                              });
                            },
                          );
                        });
                  },
                  child: Container(
                    color: Colors.lightBlue,
                    padding: EdgeInsets.all(20),
                    child: Text('새버전 출시'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            _showQr
                ? Container(
                    width: 300, height: 300, child: QrImage(data: 'qrqrqr'))
                : Text('다운받을 수 있는 파일이 없습니다.')
          ],
        ),
      ),
    );
  }
}
