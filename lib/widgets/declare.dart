import 'package:fire_evacuation_assistance_for_disabled/widgets/blueprint.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/manual.dart';
import 'package:fire_evacuation_assistance_for_disabled/components/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


  bool declareCheck = false;

// ignore: must_be_immutable
class DeclareScreen extends StatelessWidget {
  late String value;
  DeclareScreen({required this.value, super.key});

  Future<Map<String, dynamic>?> documentFinder(String serial) async {
  if (!declareCheck) {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('serial')
              .doc(serial)
              .get();

      if (!documentSnapshot.exists) {
        return null;
      }

      final data = documentSnapshot.data();
      final String? address = data?['location']; // address 추출
      final int? floor = data?['floor'];

      if (address == null) {
        return null;
      }

      DocumentReference<Map<String, dynamic>> serialDocRef =
          FirebaseFirestore.instance.collection("serial").doc(serial);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await transaction.get(serialDocRef);

        if (!snapshot.exists) {
          transaction.set(serialDocRef, {'count': 1});
        } else {
          final currentCount = snapshot.data()?['count'] ?? 0;
          transaction.update(serialDocRef, {'count': currentCount + 1});
        }
        declareCheck = true;
      });

      await incrementUserCount(address);

    } catch (e) {
      return null;
    }
  }
  return null;
}

Future<void> incrementUserCount(String address) async {
  final collectionRef = FirebaseFirestore.instance.collection('lists');
  if(address == '163 Seoulsiripdae-ro, Dongdaemun-gu, Seoul'){
    address = '서울특별시 동대문구 서울시립대로 163 (전농동)';
  }
  else if(address == '22 Majang-ro, Jung-gu, Seoul'){
    address= '서울특별시 중구 마장로 22 (신당동)';
  }
  else if (address == 'B300 Wangsimni-ro, Seongdong-gu, Seoul'){
    address= '서울특별시 성동구 왕십리로 지하300 (행당동)';
  }

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final querySnapshot = await collectionRef.where('address', isEqualTo: address).get();

    if (querySnapshot.docs.isEmpty) {
      final newDocRef = collectionRef.doc(); // 새로운 문서 ID 생성
      transaction.set(newDocRef, {
        'address': address,
        'userCount': 1,
      });
    } else {
      final docRef = querySnapshot.docs.first.reference;
      final currentData = querySnapshot.docs.first.data();
      final currentCount = currentData['userCount'] ?? 0; // 기본값 0
      transaction.update(docRef, {
        'userCount': currentCount + 1,
      });
    }
  });
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

                    await documentFinder('serialC1-1');

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
