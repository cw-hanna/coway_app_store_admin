import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

//part 'app_info_model.g.dart';

//@JsonSerializable()
class AppInfoModel {
  final String appName;
  final String os;
  final String releaseType;
  final String updateDate;
  final String version;
  final String description;
  final String owner;
  final Uint8List? imageBytes;

  AppInfoModel(this.appName, this.os, this.releaseType, this.updateDate,
      this.version, this.description, this.owner, this.imageBytes);

  // factory AppInfoModel.fromJson(Map<String, dynamic> json) =>
  //     _$AppInfoModelFromJson(json);
  // Map<String, dynamic> toJson() => _$AppInfoModelToJson(this);
}
