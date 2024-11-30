import 'package:fire_evacuation_assistance_for_disabled/widgets/blueprint.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/declare.dart';
import 'package:fire_evacuation_assistance_for_disabled/component/text_to_speech.dart';
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

const manualListVisual = [
  MaunalModel("assets/images/alarm.png", "1",
      "되도록이면 보호자와 함께 대피하고, 만약 보호자가 없을 시 크게 소리르 질러 주변에 도움을 요청한다."),
  MaunalModel("assets/images/knock.png", "2",
      "화재로 인해 고립되었을 경우, 물건이나 주변 시설을 두드려 소음을 내어 응급상황을 알린다."),
  MaunalModel(
      "assets/images/crouch.png", "3", "대피시 한쪽 벽이나 이동 손잡이 등을 이용하여 움직인다."),
  MaunalModel(
      "assets/images/exit.png", "4", " 젖은 수건으로 코와 입을 막은 채 낮은 자세로 계단을 통해 대피한다."),
]; // 이미지 URL, 타이틀숫자, 대피메뉴얼 으로 리스트 구성

const manualListWheelchair = [
  MaunalModel("assets/images/alarm.png", "1",
      "화재 발생 시 호루라기를 불거나 소리를 질러 보호자 또는 주변인에게 신속하게 도움을 요청한다."),
  MaunalModel("assets/images/knock.png", "2",
      "화재로 인해 고립되었을 경우, 물건이나 주변 시설을 두드려 소음을 내어 응급상황을 알린다."),
  MaunalModel(
      "assets/images/crouch.png", "3", "휠체어를 이용하거나 몸을 끌어서 출구 쪽으로 이동한다."),
  MaunalModel(
      "assets/images/exit.png", "4", "연기가 날 때는 젖은 손수건이나 옷으로 입과 코를 막는다."),
];

// ignore: must_be_immutable
class ManualScreen extends StatelessWidget {
  late String value;
  ManualScreen({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    //사용자의 디바이스 크기 반영을 위한 변수
    Size screenSize = MediaQuery.of(context).size;

    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    double widthRatio = screenWidth / 1080;
    double heightRatio = screenHeight / 2400; //1080x2400 에뮬레이터 기준

    final textToSpeech = TextToSpeech();
    textToSpeech.initState();

    value == 'visual' ? textToSpeech.speak('화재 대피 메뉴얼은 다음과 같습니다. 첫 째, 되도록이면 보호자와 함께 대피하고, 만약 보호자가 없을 시 크게 소리르 질러 주변에 도움을 요청한다. 둘 째, 화재로 인해 고립되었을 경우, 물건이나 주변 시설을 두드려 소음을 내어 응급상황을 알린다. 셋 째, 대피시 한쪽 벽이나 이동 손잡이 등을 이용하여 움직인다. 넷 째, 젖은 수건으로 코와 입을 막은 채 낮은 자세로 계단을 통해 대피한다.'): Null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(226, 0, 0, 0),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50 * heightRatio,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        textToSpeech.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeclareScreen(
                              value: value,
                            ),
                          ),
                        );
                      },
                      child: Text("<-Declare",
                          style: TextStyle(
                              color: const Color.fromARGB(218, 255, 0, 0),
                              fontSize: 20))),
                  TextButton(
                      onPressed: () {
                        textToSpeech.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlueprintScreen(value: value,),
                          ),
                        );
                      },
                      child: Text("대피안내도->",
                          style: TextStyle(
                              color: const Color.fromARGB(218, 255, 0, 0),
                              fontSize: 20))),
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
                    margin: EdgeInsets.all(12 * widthRatio),
                    child: value == 'visual'
                        ? ListView.builder(
                            itemCount: manualListVisual.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: EdgeInsets.only(
                                      top: 30 * heightRatio,
                                      bottom: 30 * heightRatio,
                                      right: 5 * widthRatio,
                                      left: 5 * widthRatio),
                                  width: 400 * widthRatio,
                                  height: 450 * heightRatio,
                                  padding: EdgeInsets.all(
                                      5 * widthRatio), //이미지와 컨테이너 사이 여백
                                  child: Row(
                                    children: [
                                      AspectRatio(
                                        // 이미지와 이미지오른쪽 컨테이너의 높이를 맞추기위해 사용
                                        aspectRatio: 1,
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5)),
                                            child: Image.asset(
                                                manualListVisual[index].image,
                                                fit: BoxFit.cover)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5)),
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          padding:
                                              EdgeInsets.all(10 * widthRatio),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 0),
                                                child: Text(
                                                  manualListVisual[index]
                                                      .titleNum,
                                                  style: const TextStyle(
                                                      fontSize: 27,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 15 * widthRatio),
                                                child: Text(
                                                  manualListVisual[index]
                                                      .manual,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ));
                            })
                        : ListView.builder(
                            itemCount: manualListWheelchair.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: EdgeInsets.only(
                                      top: 30 * heightRatio,
                                      bottom: 30 * heightRatio,
                                      right: 5 * widthRatio,
                                      left: 5 * widthRatio),
                                  width: 400 * widthRatio,
                                  height: 450 * heightRatio,
                                  padding: EdgeInsets.all(
                                      5 * widthRatio), //이미지와 컨테이너 사이 여백
                                  child: Row(
                                    children: [
                                      AspectRatio(
                                        // 이미지와 이미지오른쪽 컨테이너의 높이를 맞추기위해 사용
                                        aspectRatio: 1,
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5)),
                                            child: Image.asset(
                                                manualListWheelchair[index]
                                                    .image,
                                                fit: BoxFit.cover)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5)),
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          padding:
                                              EdgeInsets.all(10 * widthRatio),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 0),
                                                child: Text(
                                                  manualListWheelchair[index]
                                                      .titleNum,
                                                  style: const TextStyle(
                                                      fontSize: 27,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 15 * widthRatio),
                                                child: Text(
                                                  manualListWheelchair[index]
                                                      .manual,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
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
