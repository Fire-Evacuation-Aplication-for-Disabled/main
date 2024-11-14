import 'package:fire_evacuation_assistance_for_disabled/widgets/blueprint.dart';
import 'package:fire_evacuation_assistance_for_disabled/widgets/manual.dart';
import 'package:flutter/material.dart';

class DeclareScreen extends StatelessWidget {
  const DeclareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                  onTap: (){
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BlueprintScreen(),
                                ),
                    );
                  },
                  child: Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(189, 249, 43, 29),
                    ),
                    child: const Center(child: Text('Declare', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),),
                  ),
                ),
              ),
              // 터치 시 Manual화면으로 이동
              InkWell(
                onTap: (){
                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ManualScreen(),
                              ),
                  );
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.49,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(199, 255, 235, 59),
                  ),
                  child: const Center(child: Text('Manual',style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
