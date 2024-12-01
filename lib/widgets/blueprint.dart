import 'dart:math';
import 'package:fire_evacuation_assistance_for_disabled/components/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/manual.dart';

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
            int? upperArrow;
            int? downArrow;
            String fireLocationDescription = "";
            String myLocationDescription = "";
            if (myLocation != null && fireLocation != null) {
              upperArrow = max(myLocation, fireLocation);
              downArrow = min(myLocation, fireLocation);
            }

            fireLocationDescription = "화재🔥 : $fireLocation 층";
            myLocationDescription = "나🧑 : $myLocation 층";

            // 음성 출력
            if (value == 'visual') {
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
                    // Upper Triangle
                    CustomPaint(
                      size: Size(60, 60),
                      painter: TrianglePainter(
                        color: Color.fromARGB(218, 255, 0, 0),
                        isUpward: true,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      upperArrow != null ? '$fireLocationDescription' : 'No Data',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01094),

                    // Down Triangle
                    
                    SizedBox(height: 8),
                    Text(
                      downArrow != null ? '$myLocationDescription' : 'No Data',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30,
                      ),
                    ),
                    CustomPaint(
                      size: Size(60, 60),
                      painter: TrianglePainter(
                        color: Color.fromARGB(218, 0, 255, 0),
                        isUpward: false,
                      ),
                    ),
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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
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
