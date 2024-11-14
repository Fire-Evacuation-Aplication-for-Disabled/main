import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TO DO: 리스크 클릭 시 건물로 이동
// admin은 후순위로

class Item {
  final String title;
  final num subtitle; // subtitle의 자료형을 num으로 설정

  Item({required this.title, required this.subtitle});

  factory Item.fromFirestore(Map<String, dynamic> data) {
    return Item(
      title: data['address'] ?? 'No Title',
      subtitle: data['userCount'] ?? 0,
    );
  }
}

class AdminList extends StatelessWidget {
  const AdminList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(226, 0, 0, 0),
        appBar: AppBar(
          title: const Text('Admin List'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('lists')
              .snapshots(), // 컬렉션 이름 변경
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
      
            final docs = snapshot.data!.docs;
      
            // Item 객체 리스트로 변환
            List<Item> items = docs
                .map((doc) =>
                    Item.fromFirestore(doc.data() as Map<String, dynamic>))
                .toList();
      
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  // 카드 형식으로 표시
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding:const EdgeInsets.all(16.0),
                  child: Row(
                    // 양쪽 끝에 정렬
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        //numcount값을 string으로 변환
                        item.subtitle.toString(),
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold), // 큰 텍스트
                      ),
                    ],
                  ),
                ),
              );
              },
            );
          },
        ),
      ),
    );
  }
}
