import 'package:fire_evacuation_assistance_for_disabled/widgets/blueprint.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/manual.dart';
import 'package:fire_evacuation_assistance_for_disabled/components/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:fire_evacuation_assistance_for_disabled/components/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class DeclareScreen extends StatelessWidget {
  late String value;
  bool declareCheck = false;
  DeclareScreen({required this.value, super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> incrementUserCount(String address) async {
    try {
      final querySnapshot = await _firestore
          .collection('lists')
          .where('address', isEqualTo: address)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty && declareCheck == false) {
        final doc = querySnapshot.docs.first;
        final docRef = doc.reference;
        final currentCount = doc['userCount'] ?? 0;
        await docRef.update({'userCount': currentCount + 1});
        declareCheck = true;
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final textToSpeech = TextToSpeech();
    textToSpeech.initializeTts();

    if (value == 'visual') {
      textToSpeech
          .speak('화재 신고를 하려면 화면 상단을 누르고, 화재 대피 메뉴얼을 들으시려면 화면 하단을 눌러주세요');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 터치 시 Declare (신고) 후 다음 화면(blueprint)로 이동
              Expanded(
                child: InkWell(
                  onTap: () async {
                    textToSpeech.stop();

                    await incrementUserCount('서울특별시 동대문구 서울시립대로 163 (전농동)');

                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlueprintScreen(value: value),
                      ),
                    );
                  },
                  child: Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(189, 249, 43, 29),
                    ),
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '119 신고 ',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '📢', // 사이렌 이모티콘
                              style: TextStyle(
                                fontSize: 50, // 더 큰 크기로 설정
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 터치 시 Manual화면으로 이동
              InkWell(
                onTap: () {
                  textToSpeech.stop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManualScreen(value: value),
                    ),
                  );
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.49,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(199, 255, 235, 59),
                  ),
                  child: const Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '화재 대피 매뉴얼 ',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '📖', // 매뉴얼 이모티콘
                            style: TextStyle(
                              fontSize: 50, // 더 큰 크기로 설정
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
