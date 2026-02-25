import 'package:file_uploader/backend/datas.dart';
import 'package:flutter/material.dart';

int primaryColor = 0xFF1D3646;

class ImageListTile extends StatefulWidget {
  // imageDataとしてImageData型のインスタンスを受け取る
  final ImageData imageData;
  ImageListTile({super.key, required this.imageData});

  @override
  State<ImageListTile> createState() => _ImageListTileState();
}

class _ImageListTileState extends State<ImageListTile> {
  @override
  Widget build(BuildContext context) {
    // =========================================================================

    // プログレスバーの太さ
    const double progressHight = 10;

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

    // アイコンのサイズ
    const double iconSize = 35;

    // =========================================================================

    final fileNameField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Color(primaryColor)),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );

    final uploadProgress = LinearProgressIndicator(
      value: widget.imageData.progress,
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
      minHeight: progressHight,
      borderRadius: BorderRadius.all(Radius.circular(50)),
    );

    final previewImage = SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.close),
                color: Colors.white,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(primaryColor)),
                ),
                iconSize: iconSize,
              ),
              width: iconSize * 1.5,
            ),
          ),
        ),
        Image.memory(widget.imageData.file),
      ],
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
    );

    final previewButton = IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return previewImage;
          },
        );
      },
      icon: Icon(Icons.mms),
      color: Colors.white,
      iconSize: iconSize,
    );

    final listTile = Align(
      alignment: Alignment.center,
      child: Container(
        child: Card(
          child: ListTile(
            title: fileNameField,
            subtitle: uploadProgress,
            trailing: previewButton,
          ),
          color: Color(primaryColor),
        ),
        width: cardWidth,
      ),
    );
    return listTile;
  }
}
