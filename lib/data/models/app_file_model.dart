import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'app_info_model.g.dart';

//@JsonSerializable()
class AppFileModel {
  final String appName;
  final String os;
  final String releaseType;
  final String updateDate;
  final String version;
  final String description;
  final String owner;
  final PlatformFile? file;

  AppFileModel(this.appName, this.os, this.releaseType, this.updateDate,
      this.version, this.description, this.owner, this.file);

  // factory AppInfoModel.fromJson(Map<String, dynamic> json) =>
  //     _$AppInfoModelFromJson(json);
  // Map<String, dynamic> toJson() => _$AppInfoModelToJson(this);
}
