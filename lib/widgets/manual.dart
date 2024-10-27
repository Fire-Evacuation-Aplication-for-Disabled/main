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
        backgroundColor:const Color.fromARGB(226, 0, 0, 0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(            
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                TextButton(
                  onPressed: (){}, 
                  child: Text(
                    "<-Declare",
                    style: TextStyle(
                    color: Color.fromARGB(218, 255, 0, 0),
                    fontSize: 15))),             
             TextButton(
             onPressed: (){}, 
             child: Text(
               "대피안내도->",
               style: TextStyle(
                color: Color.fromARGB(218, 255, 0, 0),
                fontSize: 15))),
            ],
          ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(1) 
                ),
            ),
            const Center(
              child: Text(
                "화재 대피 메뉴얼 ",
                style: TextStyle(
                  color: Color.fromARGB(218, 255, 62, 62),
                  fontSize: 45, 
                  fontWeight: FontWeight.bold
                  ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 44, 44, 44)),
                margin: EdgeInsets.all(12),
                child: ListView.builder(
                    itemCount: manualList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.all(5),
                          width: 400,
                          height: 150,
                          padding: EdgeInsets.all(5), //이미지와 컨테이너 사이 여백 
                          child: Row(
                            children: [
                              ClipRRect(
                                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),topLeft:  Radius.circular(5)),
                                child: Image.asset('assets/images/testimage.png')
                                ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),topRight:  Radius.circular(5)),
                                    color: const Color.fromARGB(255, 255, 255, 255)),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top:0),
                                        child: Text(
                                          manualList[index].titleNum,
                                          style: TextStyle(
                                              fontSize: 27,
                                              color: const Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 0, left:15),
                                        child: Text(
                                          manualList[index].manual,
                                          style: TextStyle(
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
        )
      ),
    );
  }
}