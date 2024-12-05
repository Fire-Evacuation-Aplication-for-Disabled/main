import 'dart:math';
import 'package:fire_evacuation_assistance_for_disabled/components/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/manual.dart';
import 'package:fire_evacuation_assistance_for_disabled/components/dialog.dart';

bool checkedDeclare = false;

class TrianglePainter extends CustomPainter {
  final Color color;
  final bool isUpward;

  TrianglePainter({required this.color, required this.isUpward});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    if (isUpward) {
      // 위쪽 삼각형
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      // 아래쪽 삼각형
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ignore: must_be_immutable
class BlueprintScreen extends StatelessWidget {
  late String value;
  BlueprintScreen({required this.value, super.key});

  Stream<Map<String, int?>> getLocationStream() {
    return FirebaseFirestore.instance
        .collection('info_')
        .doc('location')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return {
          'myLocation': data['myLocation'] as int?,
          'fireLocation': data['fireLocation'] as int?,
        };
      }
      return {'myLocation': null, 'fireLocation': null};
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final dynamic id = 'blueprint';

    final textToSpeech = TextToSpeech();
    textToSpeech.initializeTts();

    if (value != 'visual') {
      if (!checkedDeclare) {
        dialog(context, '신고 완료', '신고가 정상적으로 접수 되었습니다.');
      }
      checkedDeclare = true;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(226, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(226, 0, 0, 0),
          centerTitle: true,
          title: TextButton(
            child: Text(
              '화재 대피 메뉴얼 보기',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 33,
                color: Color.fromARGB(218, 255, 0, 0),
              ),
            ),
            onPressed: () {
              textToSpeech.stop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManualScreen(value: value),
                ),
              );
            },
          ),
        ),
        body: StreamBuilder<Map<String, int?>>(
          stream: getLocationStream(),
          builder: (context, AsyncSnapshot<Map<String, int?>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: Text('No Info Found!'),
              );
            }

            int? myLocation = snapshot.data!['myLocation'];
            int? fireLocation = snapshot.data!['fireLocation'];

            // 큰 값과 작은 값 비교
            int? upperValue;
            int? downValue;
            String upperArrow = "";
            String downArrow = "";
            if (myLocation != null && fireLocation != null) {
              upperValue = max(myLocation, fireLocation);
              downValue = min(myLocation, fireLocation);
            }

            if (myLocation! < fireLocation!) {
              upperArrow = "화재 🔥 : $upperValue 층";
              downArrow = "나 🧒🏻 : $downValue 층";
            } else {
              upperArrow = "나 🧒🏻 : $upperValue 층";
              downArrow = "화재 🔥 : $downValue 층";
            }
            // 음성 출력
            if (value == 'visual') {
              if (!checkedDeclare) {
                checkedDeclare = true;
                textToSpeech.speak('신고가 정상적으로 접수되었습니다.'
                '화재 발생 층은 $fireLocation층이고, 현재 나의 위치는 $myLocation층입니다. '
                '화재 대피 메뉴얼을 보려면 화면 중앙 최상단을 터치하십시오.');
              }
              textToSpeech.speak(
                '화재 발생 층은 $fireLocation층이고, 현재 나의 위치는 $myLocation층입니다. '
                '화재 대피 메뉴얼을 보려면 화면 중앙 최상단을 터치하십시오.',
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    if (myLocation != fireLocation) ...[
                      // Upper Triangle
                      CustomPaint(
                        size: Size(60, 60),
                        painter: TrianglePainter(
                          color: fireLocation > myLocation // 위 화살표의 값이 fire면 빨간색, mylocation이면 초록색
                         ? Color.fromARGB(218, 255, 0, 0) // 빨간색
                         : Color.fromARGB(218, 0, 255, 38), // 초록색
                          isUpward: true,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        upperArrow,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01094),

                      // Down Triangle

                      SizedBox(height: 8),
                      Text(
                        downArrow,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 8),
                      CustomPaint(
                        size: Size(60, 60),
                        painter: TrianglePainter(
                          color: fireLocation > myLocation // 위 화살표의 값이 fire면 빨간색, mylocation이면 초록색
                         ? Color.fromARGB(218, 0, 255, 68) // 빨간색
                         : Color.fromARGB(218, 255, 0, 0),
                          isUpward: false,
                        ),
                      ),
                    ] else ...[
                      Text(
                        '화재🔥 나🧒🏻 : $myLocation층',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                        ),
                      )
                    ]
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BlueprintImage(),
                      ),
                    );
                  },
                  child: Hero(
                    tag: id,
                    child: Image.asset('assets/images/blueprint.png'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BlueprintImage extends StatefulWidget {
  const BlueprintImage({super.key});

  @override
  State<BlueprintImage> createState() => _BlueprintImageState();
}

class _BlueprintImageState extends State<BlueprintImage> {
  @override
  Widget build(BuildContext context) {
    final dynamic id = 'blueprint';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(226, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(226, 0, 0, 0),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: Center(
          child: Hero(
            tag: id,
            child: Transform.rotate(
              angle: pi / 2,
              child: Image.asset(
                'assets/images/blueprint.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
