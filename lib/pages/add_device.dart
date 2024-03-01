import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                  FirebaseFirestore.instance.collection("device").add({
                    "name": nameController.text,
                    "zone": zoneController.text,
                    // "poster": posterController.text,
                    // "categories": categories,
                    // "likes": 0
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
