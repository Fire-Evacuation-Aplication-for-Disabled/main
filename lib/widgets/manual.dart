// ******************************************************
// *
// *             파일명 : manual.dart
// *
// *             작성자 : 최유현
// *
// *             마지막 수정일 : 2024.10.26
// *
// *             파일 내용 : 메뉴얼 (반응형 x)
// *
// ******************************************************


// 주석이나 코드들은 얼마든지 바꿔도 됨 전부 밀어버리고 자기 스타일대로 하세요
// 그냥 제가 작업하면서 보려고 만든거에요


import 'package:flutter/material.dart';
// import 'package:image_network/image_network.dart'; // imageurl 을 이용하기 위한 package

class MaunalModel {
  const MaunalModel(this.imageUrl, this.titleNum, this.manual,);
  final String imageUrl;
  final String titleNum;
  final String manual;
}

const manualList = [
 MaunalModel(
      "https://placehold.co/600x400",
      "1",
      "크게 소리를 질러 주변에 도움을 요청"
      ),
  MaunalModel(
      "https://placehold.co/600x400",
      "2",
      "물건이나 주변 시설을 두드려 소음을 내어 응급상황 알리기"
      ),
  MaunalModel(
    "https://placehold.co/600x400",
      "3", 
      "한쪽 벽이나 이동 손잡이 등을 이용하여 이동" 
      ),
  MaunalModel(
    "https://placehold.co/600x400",
      "4",
       " 젖은 수건으로 코와 입을 막은 채 낮은 자세로 계단을 통해 대피"),
]; // 이미지 URL, 타이틀숫자, 대피메뉴얼 으로 리스트 구성 

class ManualScreen extends StatelessWidget {
  const ManualScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(0),
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20) 
                  ),
              ),
              const Center(
                child: Text(
                  "화재 대피 메뉴얼 ",
                  style: TextStyle(
                    color: Color.fromARGB(218, 255, 0, 0),
                    fontSize: 40, 
                    fontWeight: FontWeight.bold
                    ),
                ),
              ),
              Container(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  margin: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                      itemCount: manualList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(top: 20),
                            color: const Color.fromARGB(255, 44, 44, 44),
                            width: 400,
                            height: 200,
                            padding: const EdgeInsets.all(20), //이미지와 컨테이너 사이 여백 
                            child: Row(
                              children: [
                                Image.asset('assets/images/testimage.png'),
                                Expanded(
                                  child: Container(
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top:0),
                                          child: Text(
                                            manualList[index].titleNum,
                                            style: const TextStyle(
                                                fontSize: 27,
                                                color: Color.fromARGB(255, 0, 0, 0),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left:30),
                                          child: Text(
                                            manualList[index].manual,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ));
                      })),
            ],
          ),
        )
      ),
    );
  }
}