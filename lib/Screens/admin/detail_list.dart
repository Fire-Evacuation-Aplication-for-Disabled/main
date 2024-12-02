import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailList extends StatelessWidget {
  final String? address;

  const DetailList({required this.address, super.key});

  Future<List<Map<String, dynamic>>> documentFinder(String? address) async {
    if (address == null || address.isEmpty) {
      return [];
    }

    try {
      // Fetch all documents from the Firestore collection
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection(address)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      // Map each document into a list of data
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      return [];
    }
  }

  // Extract serial numbers by floor for all documents
  List<String> getSerialList(List<Map<String, dynamic>> documents) {
    List<String> serialList = [];

    for (var data in documents) {
      data.forEach((key, value) {
        if (key.startsWith('floor') && value is Map) {
          value.forEach((serial, count) {
            serialList.add(serial); // Add serial numbers to the list
          });
        }
      });
    }

    return serialList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('Detail Information'),
        ),
        body: Center(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: documentFinder(address),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show loading state
              }

              if (snapshot.hasError) {
                return Text('Error occurred: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No data found.');
              }

              final documents = snapshot.data!;
              final serialList = getSerialList(documents); // Extract serial numbers from all documents

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address: $address', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 16),
                    Text('Serial Numbers: ', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    // Display serial numbers in a list
                    Expanded(
                      child: ListView.builder(
                        itemCount: serialList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(serialList[index], style: TextStyle(fontSize: 16)),
                          );
                        },
                      ),
                    ),
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
