// ******************************************************************
// *
// *             파일명 : main.dart
// *
// *             작성자 : 임준용, 최유현
// *
// *             마지막 수정일 : 2024.11.05
// *
// *             파일 내용 : 장애인 대상 화재 대피 보조 어플리케이션 개발
// *
// *             작업 환경 : Window / VS Code
// *
// *             사용 언어 및 프레임워크 : dart / flutter / firebase
// *
// ******************************************************

import 'package:fire_evacuation_assistance_for_disabled/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}