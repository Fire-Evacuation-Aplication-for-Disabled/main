// ******************************************************************
// *
// *             파일명 : login.dart
// *
// *             작성자 : 임준용
// *
// *             마지막 수정일 : 2024.10.16
// *
// *             파일 내용 : 어플리케이션 '대피닷'의 login screen 개발
// *
// ******************************************************************

// 비율은 Medium Phone 사이즈에 맞추었고, 추후에 반응형으로 만들 예정

// TO DO : 전체적인 컨셉에 따라 디자인 변경, 로그인 firebase와 연결, 비율(디자인) 관리(sized box 삭제)

import 'package:flutter/material.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/declare.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/manual.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/blueprint.dart';

// 토글 버튼 텍스트
const List<Widget> disableType = <Widget>[Text('Declare'), Text('Manual'), Text('Blueprint')];

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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(226, 0, 0, 0),

        // 스크롤 활성화 -> 키보드 overflow 개선 위함
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 77,
              bottom: 40,
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
                const SizedBox(
                  height: 60,
                ),

                // 아이콘
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(235, 255, 255, 255),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Icon(
                        Icons.accessible,
                        size: 150,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                // id 입력 받는 inputBox
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                        ),
                        keyboardType: TextInputType.text,
                        controller: idController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                // pw 입력 받는 inputBox
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                        ),
                        keyboardType: TextInputType.text,
                        controller: pwController,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
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
                        constraints: const BoxConstraints(
                          minHeight: 55.0,
                          minWidth: 115.0,
                        ),
                        isSelected: _selectedDisableType,
                        children: disableType,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
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
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ManualScreen(),
                            ),
                          );
                          }
                          else if (_selectedDisableType[2] == true) {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BlueprintScreen(),
                            ),
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
