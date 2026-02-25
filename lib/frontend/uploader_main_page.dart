import 'dart:io';
import 'dart:typed_data';

import 'package:file_uploader/backend/datas.dart';
import 'package:file_uploader/frontend/uploader_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// メインの色
int primaryColor = 0xFF1D3646;

// main card padding
double card_padding = 10;

class UploaderMainPage extends StatefulWidget {
  const UploaderMainPage({super.key});

  @override
  State<UploaderMainPage> createState() => _UploaderMainPageState();
}

class _UploaderMainPageState extends State<UploaderMainPage> {
  // 画像のデータ
  List<ImageData> images = [];
  // ファイル選択
  Future pickFile() async {
    // ファイルデータを格納する変数
    final List<Uint8List> _images = [];
    // image_pickerのインスタンスを生成
    final picker = ImagePicker();

    // 選択したファイルを変数に格納する
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    final List fileBytesList = await Future.wait(
      pickedFiles!.map((e) => e.readAsBytes()),
    );

    images.clear();
    _images.clear();
    setState(() {
      fileBytesList.forEach((pickFile) {
        _images.add(pickFile);
      });
    });
    // images = _images;
    // 取得したデータをもとにクラスとして配列に格納していく
    _images.forEach((image) {
      String fileName = DateFormat(
        "yyyy-MM-dd_HH-mm-ss",
      ).format(DateTime.now()); // デフォルトのファイル名は時刻
      ImageData imageInstance = ImageData(
        _images.indexOf(image), //id
        image, //data
        fileName, // file name
      );
      images.add(imageInstance);
      print(imageInstance);
    });

    return _images;
  }

  @override
  Widget build(BuildContext context) {
    // 画面のサイズ

    final mediaSize = MediaQuery.of(context).size;
    double cardWidth = 80;
    double cardHeight = mediaSize.height * 0.3;
    if (mediaSize.width > mediaSize.height) {
      // 横が広い
      cardWidth = mediaSize.width * 0.6;
      cardHeight = mediaSize.height * 0.3;
    } else {
      // 縦が広い
      cardWidth = mediaSize.width * 0.9;
      cardHeight = mediaSize.height * 0.2;
    }

    var appBar = AppBar(
      title: Text("File Uploader", style: TextStyle(color: Colors.white)),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu, color: Colors.white),
      ),
      backgroundColor: Color(primaryColor),
    );

    // URLを入力するフィールド
    double fieldWidth = cardWidth * 0.8;
    var urlField = Container(
      child: TextField(
        style: TextStyle(color: Color(primaryColor)),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      padding: EdgeInsets.all(card_padding),
      width: fieldWidth,
    );

    // 画像を選択するボタン
    var selectPicture = ElevatedButton.icon(
      onPressed: () {
        // 画像を選択
        pickFile();
      },
      label: Text("Pick Image"),
      icon: Icon(Icons.image),
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Color(primaryColor)),
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    );

    var mainCard = Container(
      child: Card(
        color: Color(primaryColor),
        child: Column(
          children: [urlField, selectPicture],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
      width: cardWidth,
      height: cardHeight,
    );

    var listView = Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: images.length,
        itemBuilder: (context, index) {
          var listTile = ImageListTile(imageData: images[index]);

          return listTile;
        },
      ),
    );

    var mainContent = Column(
      children: [mainCard, listView],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
    var content = MaterialApp(
      home: Scaffold(
        appBar: appBar,
        body: Center(child: mainContent),
      ),
    );

    return content;
  }
}
