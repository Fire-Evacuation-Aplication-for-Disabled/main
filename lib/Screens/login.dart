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

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(141, 0, 0, 0),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 60,
            bottom: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Center(
                child: Text(
                  '화재 대피 어플리케이션',
                  style: TextStyle(
                    color: Color.fromARGB(232, 255, 255, 255),
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),const Center(
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
                height: 36,
              ),
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(235, 255, 255, 255),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(88.0),
                    child: Text(
                      'Logo',
                      style: TextStyle(
                          color: Color.fromARGB(139, 255, 0, 0),
                          fontSize: 50,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisSize : MainAxisSize.max,
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
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        filled:true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: 'insert id',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(86, 34, 33, 33),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        )
                      ),
                      keyboardType: TextInputType.text,
                      controller: idController,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 0,
              ),
              Row(
                mainAxisSize : MainAxisSize.max,
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
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        filled:true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: 'insert pw',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(123, 187, 15, 15),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        )
                      ),
                      keyboardType: TextInputType.text,
                      controller: pwController,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
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
    );
  }
}