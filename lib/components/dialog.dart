import 'package:flutter/material.dart';

void dialog(BuildContext context, String title, String content) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false, // Dialog 외부 터치 방지
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  });
}
