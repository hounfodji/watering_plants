import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/theme/colors.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final nameController = TextEditingController();
  final zoneController = TextEditingController();
  // final posterController = TextEditingController();
  // List<String> categories = [];

  @override
  Widget build(BuildContext context) {
    var dTime = DateTime.now().millisecondsSinceEpoch.toString();

    // final ref = fb.ref().child('todos/$k');
    final User? currentUser = FirebaseAuth.instance.currentUser;
    DatabaseReference databaseReferenceDeviceInfos = FirebaseDatabase.instance
        .ref()
        .child('UsersData')
        .child(currentUser!.uid)
        .child("readings")
        .child(dTime);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add Device",
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.white30, width: 1.5)),
              title: Row(
                children: [
                  const Text("Name: "),
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    controller: nameController,
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // zone
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.white30, width: 1.5)),
              title: Row(
                children: [
                  const Text("Zone: "),
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    controller: zoneController,
                  ))
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // // poster
            // ListTile(
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: const BorderSide(color: Colors.white30, width: 1.5)),
            //   title: Row(
            //     children: [
            //       const Text("Poster: "),
            //       Expanded(child: TextField(
            //         decoration: const InputDecoration(
            //           border: InputBorder.none
            //         ),
            //         controller: posterController,
            //       ))
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 20),
            // categories

            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: secondaryColor),
                onPressed: () {
                  databaseReferenceDeviceInfos.set({
                   
                    "name": nameController.text,
                    "zone": zoneController.text,
                    "timestamps" : dTime,
                    "deviceStatut": false,
                    "tvoc": 800.22,
                    "barometricPressure": 1000.22,
                    "co2": 1002.55,
                    "temperature": 20.34,
                    "humidity": 50.2,
                  });

                    FirebaseFirestore.instance.collection("device").add({
                    "name": nameController.text,
                    "zone": zoneController.text,
                    "timestamps" : dTime,
                    "tvoc": 800.22,
                    "barometricPressure": 1000.22,
                    "co2": 1002.55,
                    "temperature": 20.34,
                    "humidity": 50.2,
                    "deviceStatut": false,
                    "minMaxValue": {
                      "tvoc": [405, 1340],
                      "barometricPressure": [142, 1017],
                      "co2": [812, 2200],
                      "temperature": [0, 40],
                      "humidity": [0, 100]
                    },
                    "unite": {
                      "tvoc": "ppm",
                      "barometricPressure": "ppm",
                      "co2": "ppm",
                      "temperature": "°C",
                      "humidity": "%H"
                    }
                  });

                  Navigator.pop(context);
                },
                child: const Text("Add"))
          ],
        ),
      ),
    );
  }
}
