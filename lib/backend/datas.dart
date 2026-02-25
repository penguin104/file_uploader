import 'dart:typed_data';

class ImageData {
  int id; // 識別番号
  Uint8List file; // ファイルデータ
  String fileName; // ファイル名
  double progress = 0; // アップロード進捗
  ImageData(this.id, this.file, this.fileName);
}
