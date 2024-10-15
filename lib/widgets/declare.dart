// ******************************************************
// *
// *             파일명 : declare.dart
// *
// *             작성자 : 
// *
// *             마지막 수정일 : 2024
// *
// *             파일 내용 : 
// *
// ******************************************************

import 'package:flutter/material.dart';

class DeclareScreen extends StatelessWidget {
  const DeclareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Declare Screen',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('back'),),
            ),
          ],
        ),
      ),
    );
  }
}
