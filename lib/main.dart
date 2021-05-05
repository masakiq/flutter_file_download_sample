import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      home: JsonFileDownload(),
    ),
  );
}

class JsonFileDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      'hoge': 'hoge',
    };
    var jsonString = json.encode(data);
    // var bytes = jsonString.codeUnits;
    final blob = html.Blob([jsonString], 'application/json');

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Open"),
              onPressed: () {
                final url = html.Url.createObjectUrlFromBlob(blob);
                html.window.open(url, "_blank");
                html.Url.revokeObjectUrl(url);
              },
            ),
            RaisedButton(
              child: Text("Download"),
              onPressed: () {
                final url = html.Url.createObjectUrlFromBlob(blob);
                final anchor =
                    html.document.createElement('a') as html.AnchorElement
                      ..href = url
                      ..style.display = 'none'
                      ..download = 'hoge.json';
                html.document.body.children.add(anchor);
                anchor.click();
                html.document.body.children.remove(anchor);
                html.Url.revokeObjectUrl(url);
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
