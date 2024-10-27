// ******************************************************
// *
// *             파일명 : declare.dart
// *
// *             작성자 : 임준용
// *
// *             마지막 수정일 : 2024.10.16
// *
// *             파일 내용 : 119 신고 혹은 메뉴얼 선택 화면
// *
// ******************************************************

import 'package:flutter/material.dart';

class DeclareScreen extends StatelessWidget {
  const DeclareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Declare',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            
            Center(
              child: Text(
                'Manual',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
