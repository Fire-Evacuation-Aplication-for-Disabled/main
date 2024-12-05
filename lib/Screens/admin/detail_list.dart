import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailList extends StatefulWidget {
  final String address;

  const DetailList({super.key, required this.address});

  @override
  State<DetailList> createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> DetailList = [];

  @override
  void initState() {
    super.initState();
    fetchSerialData();
  }

  Future<void> fetchSerialData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('serial').get();

      List<Map<String, dynamic>> dataList = [];
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        if (data['location'] == widget.address) {
          dataList.add({
            'floor': data['floor'],
            'count': data['count'],
            'room': data['room'],
          });
        }
      }

      setState(() {
        DetailList = dataList;
      });
    // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final List<bool> floorCheck = <bool>[false, false, false];
    return Scaffold(
      appBar: AppBar(
        title: Text('요구조자 상세 위치'),
      ),
      body: DetailList.isEmpty
          ? Center(child: Text('상세 정보가 존재하지 않습니다.',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),))
          : ListView.builder(
              itemCount: DetailList.length,
              itemBuilder: (context, index) {
                final data = DetailList[index];
                if(data['count'] == null || data['count'] == 0){
                  return null;
                }
                if (data['floor'] == 1){
                  if (!floorCheck[0]) {
                    floorCheck[0] = true;
                    return ListTile(
                      title: Center(child: Text('${data['floor']}층',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),)),
                      subtitle: Card(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('${data['room']}호실  |  요구조자: ${data['count']}명'),),
                      )),
                    );
                  }
                  return ListTile(
                      subtitle: Card(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('${data['room']}호실  |  요구조자: ${data['count']}명'),),
                      )),
                  );
                }
                if (data['floor'] == 2){
                  if (!floorCheck[1]) {
                    floorCheck[1] = true;
                    return ListTile(
                      title: Center(child: Text('${data['floor']}층',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),)),
                      subtitle: Card(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('${data['room']}호실  |  요구조자: ${data['count']}명'),),
                      )),
                    );
                  }
                  return ListTile(
                      subtitle: Card(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('${data['room']}호실  |  요구조자: ${data['count']}명'),),
                      )),
                  );
                }
                if (data['floor'] == 3){
                  if (!floorCheck[2]) {
                    floorCheck[2] = true;
                    return ListTile(
                      title: Center(child: Text('${data['floor']}층',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),)),
                      subtitle: Card(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('${data['room']}호실  |  요구조자: ${data['count']}명'),),
                      )),
                    );
                  }
                  return ListTile(
                      subtitle: Card(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('${data['room']}호실  |  요구조자: ${data['count']}명'),),
                      )),
                  );
                }
                return null;
              },
            ),
    );
  }
}
