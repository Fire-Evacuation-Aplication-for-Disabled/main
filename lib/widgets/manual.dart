import 'package:fire_evacuation_assistance_for_disabled/widgets/blueprint.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/declare.dart';
import 'package:flutter/material.dart';
// import 'package:image_network/image_network.dart'; // imageurl 을 이용하기 위한 package

// TO DO: manaual firebase에 있는 리스트 불러와서 시각, 휠체어에 각각 라우팅되도록 변경

class MaunalModel {
  const MaunalModel(
    this.image,
    this.titleNum,
    this.manual,
  );
  final String image;
  final String titleNum;
  final String manual;
}

const manualList = [
  MaunalModel("assets/images/alarm.png", "1", "크게 소리를 질러 주변에 도움을 요청"),
  MaunalModel(
      "assets/images/knock.png", "2", "물건이나 주변 시설을 두드려 소음을 내어 응급상황 알리기"),
  MaunalModel("assets/images/crouch.png", "3", "한쪽 벽이나 이동 손잡이 등을 이용하여 이동"),
  MaunalModel("assets/images/exit.png", "4",
        " 젖은 수건으로 코와 입을 막은 채 낮은 자세로 계단을 통해 대피"),
]; // 이미지 URL, 타이틀숫자, 대피메뉴얼 으로 리스트 구성



class ManualScreen extends StatelessWidget {
  const ManualScreen({super.key});
  @override
  Widget build(BuildContext context) {
    //사용자의 디바이스 크기 반영을 위한 변수
    Size screenSize = MediaQuery.of(context).size; 

    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    double widthRatio = screenWidth / 1080;
    double heightRatio = screenHeight / 2400; //1080x2400 에뮬레이터 기준

    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(226, 0, 0, 0),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DeclareScreen(),
                          ),
                                  );},
                      child: Text("<-Declare",
                          style: TextStyle(
                              color: const Color.fromARGB(218, 255, 0, 0),
                              fontSize: 30* widthRatio))),
                  TextButton(
                      onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BlueprintScreen(),
                          ),
                                  );},
                      child: Text("대피안내도->",
                          style: TextStyle(
                              color: const Color.fromARGB(218, 255, 0, 0),
                              fontSize: 30* widthRatio))),
                ],
              ),
              const Center(
                child: Padding(padding: EdgeInsets.all(1)),
              ),
              const Center(
                child: Text(
                  "화재 대피 메뉴얼 ",
                  style: TextStyle(
                      color: Color.fromARGB(218, 255, 62, 62),
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 44, 44, 44)),
                    margin: EdgeInsets.all(12* widthRatio),
                
                    child: ListView.builder(
                        itemCount: manualList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(
                                top:30* heightRatio,
                                bottom:30* heightRatio,
                                right: 5* widthRatio,
                                left: 5* widthRatio),
                              width: 400* widthRatio,
                              height: 450* heightRatio,
                              padding: EdgeInsets.all(5* widthRatio), //이미지와 컨테이너 사이 여백
                              child: Row(
                                children: [
                                  AspectRatio( // 이미지와 이미지오른쪽 컨테이너의 높이를 맞추기위해 사용
                                    aspectRatio:1,
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            topLeft: Radius.circular(5)),
                                        child: Image.asset(
                                            manualList[index].image,
                                            fit: BoxFit.cover)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          color:
                                              Color.fromARGB(255, 255, 255, 255)),
                                      padding: EdgeInsets.all(10* widthRatio),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 0),
                                            child: Text(
                                              manualList[index].titleNum,
                                              style: const TextStyle(
                                                  fontSize: 27,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 15* widthRatio),
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
              ),
            ],
          )),
    );
  }
}
