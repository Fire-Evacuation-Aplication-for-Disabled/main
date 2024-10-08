// ******************************************************
// *
// *             파일명 : login.dart
// *
// *             작성자 : 임준용
// *
// *             마지막 수정일 : 2024.10.06
// *
// ******************************************************

// TO DO : 전체적인 컨셉에 따라 디자인 변경, 로고 설정 및 기능,    코드 주석 추가

import 'package:flutter/material.dart';

// 장애 유형 선택 및 페이지 라우팅을 위한 버튼 함수 (작업중)

// class ButtonForType extends StatefulWidget {
//   const ButtonForType({super.key});

//   @override
//   State<ButtonForType> createState() => _ButtonForTypeState();
// }

// class _ButtonForTypeState extends State<ButtonForType> {
//   var isSelected = [false, false, false];

//   @override
//   Widget build(BuildContext context) {
//     return ToggleButtons(
//         fillColor: Colors.grey,
//         selectedBorderColor: Colors.white,
//         selectedColor: Colors.white,
//         onPressed: (int index) {
//           for (int buttonIndex = 0;
//           buttonIndex < isSelected.length;
//           buttonIndex++) {
//             isSelected[buttonIndex] = buttonIndex == index;
//           }
//         },
//         isSelected: isSelected,
//         children: const [
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 2,
//               vertical: 2,
//             ),
//           ),
//         ]);
//   }
// }


// login을 하고 장애 유형을 선택하여 해당하는 페이지로 넘어가도록 하는 함수

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController idController = TextEditingController();                  // id 입력값
  final TextEditingController pwController = TextEditingController();                  // pw 입력값

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(141, 0, 0, 0),
        body: SingleChildScrollView(                                                   // 스크롤 활성화 -> 키보드 overflow 개선 위함
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 77,
              bottom: 40,
            ),
            child: Column(
              children: [
                const Center(                                                          // 어플리케이션 소개 텍스트
                  child: Text(
                    '화재 대피 어플리케이션',
                    style: TextStyle(
                      color: Color.fromARGB(232, 255, 255, 255),
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Center(
                  child: Text(                                                         // 어플리케이션 이름
                    '\' 대피닷 \'',
                    style: TextStyle(
                      color: Color.fromARGB(218, 255, 0, 0),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 66,
                ),
                Center(                                                                // 아이콘
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
                  height: 66,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'id :',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(                                                        // id 입력 받는 inputBox, ( Expended -> 남은 공간 모두 차지 )
                      child: TextField(
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'insert id',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(86, 34, 33, 33),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            )),
                        keyboardType: TextInputType.text,
                        controller: idController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'pw :',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(                                                        // pw 입력 받는 inputBox
                      child: TextField(
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'insert pw',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(123, 187, 15, 15),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            )),
                        keyboardType: TextInputType.text,
                        controller: pwController,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 44,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(                                                            // Button -> 변경 필요
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          'select 1',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          'select 2',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          'select 3',
                          style: TextStyle(
                            color: Colors.white,
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