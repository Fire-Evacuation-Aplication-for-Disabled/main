// ******************************************************************
// *
// *             파일명 : login.dart
// *
// *             작성자 : 임준용
// *
// *             마지막 수정일 : 2024.10.25
// *
// *             파일 내용 : 어플리케이션 '대피닷'의 login screen 개발
// *
// *             작업 환경 : Window / VS Code
// *
// *             사용 언어 및 프레임워크 : dart / flutter
// *
// ******************************************************

// TO DO : 전체적인 컨셉에 따라 디자인 변경, 로그인 firebase와 연결

import 'package:flutter/material.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/declare.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/blueprint.dart';

// 토글 버튼 텍스트
const List<Widget> disableType = <Widget>[Text('시각'), Text('휠체어'), Text('관리자')];

// login screen (어플리케이션 이름 및 아이콘 출력 / id, pw와 장애 유형을 선택받고 해당하는 다음 화면으로 라우팅)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // id,pw 입력값 변수
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  // 장애 유형 유형 선택 유무
  final List<bool> _selectedDisableType = <bool>[false, false, false];

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(226, 0, 0, 0),

        // 스크롤 활성화 -> 키보드 overflow 개선 위함
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.07292,
              right: size.width * 0.07292,
              top: size.height * 0.08422,
              bottom: size.height * 0.04375,
            ),
            child: Column(
              children: [
                // 어플리케이션 소개 텍스트
                const Center(
                  child: Text(
                    '화재 대피 어플리케이션',
                    style: TextStyle(
                      color: Color.fromARGB(232, 255, 255, 255),
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                // 어플리케이션 이름 텍스트
                const Center(
                  child: Text(
                    '\' 대피닷 \'',
                    style: TextStyle(
                      color: Color.fromARGB(218, 255, 0, 0),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.06563,
                ),

                // 아이콘
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(235, 255, 255, 255),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.12153, vertical: size.height * 0.05469),
                      child: const Icon(
                        Icons.accessible,
                        size: 150,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.054688
                ),

                // id 입력 받는 inputBox
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02188, horizontal: size.width * 0.02431),
                        ),
                        keyboardType: TextInputType.text,
                        controller: idController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02188,
                ),

                // pw 입력 받는 inputBox
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02188, horizontal: size.width * 0.02431),
                        ),
                        keyboardType: TextInputType.text,
                        controller: pwController,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03938,
                ),

                // 장애 유형 선택 버튼
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0;
                                i < _selectedDisableType.length;
                                i++) {
                              _selectedDisableType[i] = i == index;
                            }
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14)),
                        borderColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        selectedBorderColor: Colors.red[700],
                        selectedColor: Colors.white,
                        fillColor: const Color.fromARGB(139, 255, 67, 67),
                        color: Colors.red[400],
                        constraints: BoxConstraints(
                          minHeight: size.height * 0.06015,
                          minWidth: size.width * 0.27951,
                        ),
                        isSelected: _selectedDisableType,
                        children: disableType,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: size.height * 0.03281,
                ),

                // 로그인 버튼 추후 pushAndRemoveUntil로 변경?
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          if (_selectedDisableType[0] == true) {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeclareScreen(),
                            ),
                          );
                          }
                          else if (_selectedDisableType[1] == true) {
                            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeclareScreen(),
                            ),
                            (route) => false,
                          );
                          }
                          else if (_selectedDisableType[2] == true) {
                            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BlueprintScreen(),
                            ),
                            (route) => false,
                          );
                          }
                        },
                        child: const Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
