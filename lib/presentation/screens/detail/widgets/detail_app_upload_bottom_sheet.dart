import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:private_store_admin/config/theme/cw_colors.dart';
import 'package:private_store_admin/data/models/app_info_model.dart';
import 'package:private_store_admin/presentation/screens/main/main_screen.dart';
import 'package:private_store_admin/presentation/widget/app_list_item.dart';

import 'package:cross_file/cross_file.dart';

class DetailAppUploadBottomSheet extends StatefulWidget {
  final AppUploadDragCallback dargUploadCallback;
  final AppUploadFineCallback findUploadCallback;

  const DetailAppUploadBottomSheet(
      {Key? key,
      required this.dargUploadCallback,
      required this.findUploadCallback})
      : super(key: key);

  @override
  State<DetailAppUploadBottomSheet> createState() =>
      _MainAddAppBottomSheetState();
}

class _MainAddAppBottomSheetState extends State<DetailAppUploadBottomSheet> {
  bool _dragging = false;

  Color uploadingColor = Colors.blue[100]!;
  Color defaultColor = Colors.grey[400]!;

  var _showFileName = '';

  XFile? _selectedFileDrag;
  PlatformFile? _selectedFileFind;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 200),
      padding: EdgeInsets.all(30),
      width: double.infinity,
      child: Column(
        children: [
          //닫기
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/close.png'),
            ),
          ),

          DropTarget(
            onDragDone: (detail) async {
              if (detail != null && detail.files.isNotEmpty) {
                String fileName = detail.files.first.name;

                Uint8List fileBytes = await detail.files.first.readAsBytes();
                setState(() {
                  _showFileName = "선택된 파일: $fileName";
                  _selectedFileDrag = detail.files.first;
                  _selectedFileFind = null;
                });
              }
            },
            onDragEntered: (detail) {
              setState(() {
                _dragging = true;
              });
            },
            onDragExited: (detail) {
              setState(() {
                _dragging = false;
              });
            },
            child: makeDropZone(),
          ),

          GestureDetector(
            onTap: () {
              if (_selectedFileDrag != null) {
                widget.dargUploadCallback(_selectedFileDrag);
              } else if (_selectedFileFind != null) {
                widget.findUploadCallback(_selectedFileFind);
              }
               Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.lightBlue,
              padding: EdgeInsets.all(20),
              child: Text('업로드'),
            ),
          ),
        ],
      ),
    );
  }

  Container makeDropZone() {
    Color color = _dragging ? uploadingColor : defaultColor;
    return Container(
      height: 200,
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: color,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "파일 드래그앤드롭",
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['apk'],
              );
              if (result != null && result.files.isNotEmpty) {
                String fileName = result.files.first.name;
                Uint8List fileBytes = result.files.first.bytes!;
                debugPrint(fileName);
                setState(() {
                  _showFileName = "선택된 파일: $fileName";
                  _selectedFileFind = result.files.first;
                  _selectedFileDrag = null;
                });
                /*
                do jobs
                 */
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "or ",
                  style: TextStyle(
                    color: color,
                  ),
                ),
                Text(
                  "파일선택",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.upload_rounded,
                  color: color,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            _showFileName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
