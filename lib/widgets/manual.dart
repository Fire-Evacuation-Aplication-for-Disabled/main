// ******************************************************
// *
// *             파일명 : manual.dart
// *
// *             작성자 : 최유현
// *
// *             마지막 수정일 : 2024.10.
// *
// *             파일 내용 : 
// *
// ******************************************************


// 주석이나 코드들은 얼마든지 바꿔도 됨 전부 밀어버리고 자기 스타일대로 하세요
// 그냥 제가 작업하면서 보려고 만든거에요


import 'package:flutter/material.dart';

class ManualScreen extends StatelessWidget {
  const ManualScreen({super.key});

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
                'Manual Screen',
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
