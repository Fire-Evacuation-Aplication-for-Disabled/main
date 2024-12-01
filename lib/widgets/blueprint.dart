import 'dart:math';
import 'package:fire_evacuation_assistance_for_disabled/components/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/manual.dart';

// TO DO: location 그림 위에 표시

// ignore: must_be_immutable
class BlueprintScreen extends StatelessWidget {
  late String value;
  BlueprintScreen({required this.value, super.key});

  Stream<Map<String, String?>> getLocationStream() {
    return FirebaseFirestore.instance
        .collection('info_')
        .doc('location')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return {
          'myLocation': data['myLocation'] as String?,
          'fireLocation': data['fireLocation'] as String?,
        };
      }
      return {'myLocation': null, 'fireLocation': null};
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final dynamic id = 'blueprint';
    late String? myLocation;
    late String? fireLocation;

    final textToSpeech = TextToSpeech();
    textToSpeech.initializeTts();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(226, 0, 0, 0),
        // appBar로 뒤로 이동할 수 있는 back_arrow 생성
        appBar: AppBar(
          backgroundColor: Color.fromARGB(226, 0, 0, 0),
          centerTitle: true,
          title: TextButton(
              child: Text('화재 대피 메뉴얼 보기',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 33, color: Color.fromARGB(218, 255, 0, 0)),),
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
        body: StreamBuilder<Map<String, String?>>(
            stream: getLocationStream(),
            builder: (context, AsyncSnapshot<Map<String, String?>> snapshot) {
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
              myLocation = snapshot.data!['myLocation'];
              fireLocation = snapshot.data!['fireLocation'];

              final textToSpeech = TextToSpeech();
              value == 'visual' ? textToSpeech.speak('화재 발생 층은 $fireLocation이고, 현재 나의 위치는 $myLocation입니다. 화재 대피 메뉴얼을 보려면 화면 중앙 최상단을 터치하십시오.') : false;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(225, 255, 255, 255),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03039,
                                vertical: size.height * 0.00868),
                            child: Text(
                              myLocation ?? 'Not Found',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: size.height * 0.01094,
                      ),
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.06077,
                                vertical: size.height * 0.01735),
                            child: Text(
                              fireLocation ?? 'Not Found',
                              style: TextStyle(
                                color: Color.fromARGB(218, 255, 0, 0),
                                fontSize: 30,
                              ),
                            ),
                          )),
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
                          child: Image.asset('assets/images/blueprint.png')))
                ],
              );
            }),
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
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Hero(
              tag: id,
              child: Transform.rotate(
                  angle: pi / 2,
                  child: Image.asset(
                    'assets/images/blueprint.png',
                    fit: BoxFit.cover,
                  ))),
        ),
      ),
    );
  }
}
