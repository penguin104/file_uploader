import 'package:file_uploader/main.dart';
import 'package:flutter/material.dart';

// メインの色
int primaryColor = 0xFF1D3646;

// main card padding
double card_padding = 20;

class UploaderMainPage extends StatelessWidget {
  const UploaderMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 画面のサイズ

    final mediaSize = MediaQuery.of(context).size;

    double cardWidth = 80;
    double cardHeight = mediaSize.height * 0.3;

    if (mediaSize.width > mediaSize.height) {
      cardWidth = mediaSize.width * 0.6;
      cardHeight = mediaSize.height * 0.3;
    } else {
      cardWidth = mediaSize.width * 0.8;
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
      onPressed: () {},
      label: Text("Pick Image"),
      icon: Icon(Icons.image),
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

    var mainContent = Column(
      children: [mainCard],
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
