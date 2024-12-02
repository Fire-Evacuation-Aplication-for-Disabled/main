import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailList extends StatelessWidget {
  final String? address;

  const DetailList({required this.address, super.key});

  Future<Map<String, dynamic>?> documentFinder(String? address) async {
    if (address == null || address.isEmpty) {
      print("주소가 null 또는 빈 값입니다.");
      return null;
    }

    try {
      // Firestore에서 문서 가져오기
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('address') // 'address' 컬렉션
              .doc(address) // 문서 ID로 address 사용
              .get();

      if (!documentSnapshot.exists) {
        print("문서를 찾을 수 없습니다: $address");
        return null;
      }

      return documentSnapshot.data(); // 문서 데이터 반환
    } catch (e) {
      print("Firestore 오류 발생: $e");
      return null;
    }
  }

  // 층에 따른 시리얼 번호 리스트 추출 함수
  List<String> getSerialList(Map<String, dynamic> data) {
    List<String> serialList = [];

    // 'floor'로 시작하는 모든 필드를 검색
    data.forEach((key, value) {
      if (key.startsWith('floor')) {
        // 각 층에 대해 시리얼 번호를 추출
        value.forEach((serial, count) {
          serialList.add(serial); // 시리얼 번호를 리스트에 추가
        });
      }
    });

    return serialList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Detail List'),
        ),
        body: Center(
          child: FutureBuilder<Map<String, dynamic>?>(
            future: documentFinder(address),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // 로딩 상태 표시
              }

              if (snapshot.hasError) {
                return Text('오류 발생: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Text('데이터를 찾을 수 없습니다.');
              }

              final data = snapshot.data!;
              final serialList = getSerialList(data); // 층에 따른 시리얼 번호 리스트 추출

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('주소: $address', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 16),
                    Text('시리얼 번호 리스트:', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    // 시리얼 번호를 리스트로 표시
                    ...serialList.map((serial) => Text(serial, style: TextStyle(fontSize: 16))),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
