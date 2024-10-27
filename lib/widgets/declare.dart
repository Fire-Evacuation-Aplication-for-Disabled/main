// ******************************************************
// *
// *             파일명 : declare.dart
// *
// *             작성자 : 임준용
// *
// *             마지막 수정일 : 2024.10.25
// *
// *             파일 내용 : 119 신고 혹은 메뉴얼 선택 화면
// *
// *             작업 환경 : Window / VS Code
// *
// *             사용 언어 및 프레임워크 : dart / flutter
// *
// ******************************************************

import 'package:fire_evacuation_assistance_for_disabled/widgets/blueprint.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/manual.dart';
import 'package:flutter/material.dart';

class DeclareScreen extends StatelessWidget {
  const DeclareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 터치 시 Declare (신고) 후 다음 화면(blueprint)로 이동
            InkWell(
              onTap: (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BlueprintScreen(),
                            ),
                );
              },
              child: Expanded(
                child: Container(
                  width: size.width,
                  height: size.height * 0.45,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(189, 249, 43, 29),
                  ),
                  child: const Center(child: Text('Declare', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),),
                ),
              ),
            ),
            // 터치 시 Manual화면으로 이동
            InkWell(
              onTap: (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ManualScreen(),
                            ),
                );
              },
              child: Container(
                width: size.width,
                height: size.height * 0.45,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(199, 255, 235, 59),
                ),
                child: const Center(child: Text('Manual',style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
