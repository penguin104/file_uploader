import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_uploader/backend/datas.dart';
import 'package:file_uploader/frontend/uploader_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// =============================================================================
// 処理系
// =============================================================================

// ファイルアプロード処理

Future<String> uplaodFile(
  Uint8List uploadFile,
  String uploadUrl,
  String fileName, [
  String userName = "guest",
  String passWord = "password",
]) async {
  final url = Uri.parse("$uploadUrl/$fileName");
  final respose = await http.put(url, body: uploadFile);
  if (respose.statusCode == 200) {
    print("正常動作");
    return "success";
  } else {
    print("error ${respose.statusCode}");
    return "${respose.statusCode}";
  }
}

// 進捗あり

Future<double> uploadFileProgress(
  Uint8List uploadFile,
  String uploadUrl,
  String fileName, [
  String userName = "guest",
  String passWord = "password",
]) async {
  final url = "$uploadUrl/$fileName";

  Dio dio = Dio();
  double progress = 0.0;

  await dio.put(
    url,
    data: uploadFile,
    onSendProgress: (count, total) {
      progress = count / total * 100;
    },
  );

  return progress;
}

Future<void> uplaodImage(
  List<ImageData> imageList,
  String url, [
  String userName = "",
  String password = "",
]) async {
  imageList.forEach((image) async {
    image.progress = await uploadFileProgress(image.file, url, image.fileName);
  });
}
