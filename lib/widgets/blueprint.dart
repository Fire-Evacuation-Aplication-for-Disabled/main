// *********************************************************************************************
// *
// *             파일명 : blueprint.dart
// *
// *             작성자 : 임준용
// *
// *             마지막 수정일 : 2024.11.05
// *
// *             파일 내용 : 대피를 위한 건물 모형도를 제공해주며, 화재 발생 층 및 내가 위치한 층 표시
// *
// **********************************************************************************************

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlueprintScreen extends StatelessWidget {
  const BlueprintScreen({super.key});

  Stream<Map<String,String?>> getLocationStream() {
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
          return {'myLocation':null, 'fireLocation':null};
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final dynamic id = 'blueprint';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar로 뒤로 이동할 수 있는 back_arrow 생성
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: StreamBuilder<Map<String,String?>>(
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
                return Center(child: Text('No Info Found!'),);
              }
              String? myLocation = snapshot.data!['myLocation'];
              String? fireLocation = snapshot.data!['fireLocation'];
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(226, 0, 0, 0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03039,
                                vertical: size.height * 0.00868),
                            child: Text(
                              myLocation ?? 'Not Found',
                              style: TextStyle(
                                color: Color.fromARGB(235, 255, 255, 255),
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
                            color: Color.fromARGB(226, 0, 0, 0),
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
                  SizedBox(
                    height: size.height * 0.01094,
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
                tag: id,
                child: Transform.rotate(
                    angle: 3.141592 / 2,
                    child: Image.asset(
                      'assets/images/blueprint.png',
                      fit: BoxFit.contain,
                    ))),
          ],
        ),
      ),
    );
  }
}
