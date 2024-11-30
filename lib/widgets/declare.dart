import 'package:fire_evacuation_assistance_for_disabled/widgets/blueprint.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/manual.dart';
import 'package:fire_evacuation_assistance_for_disabled/component/TextToSpeech.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeclareScreen extends StatelessWidget {
  late String value;
  DeclareScreen({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final textToSpeech = TextToSpeech();
    textToSpeech.initState();

    value == 'visual' ? textToSpeech.speak('화재 신고를 하려면 화면 상단을 누르고, 화재 대피 메뉴얼을 들으시려면 화면 하단을 눌러주세요') : Null;

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
                  onTap: () {
                    textToSpeech.stop();
                    Navigator.push(
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
                      child: Text(
                        'Declare',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
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
                    child: Text(
                      'Manual',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
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
