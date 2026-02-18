import 'package:flutter/material.dart';

int primaryColor = 0xFF1D3646;

class UploaderMainPage extends StatelessWidget {
  const UploaderMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("File Uploader", style: TextStyle(color: Colors.white)),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu, color: Colors.white),
      ),
      backgroundColor: Color(primaryColor),
    );

    var content = MaterialApp(home: Scaffold(appBar: appBar));

    return content;
  }
}
