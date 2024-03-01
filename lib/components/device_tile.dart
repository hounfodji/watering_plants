import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/pages/device_details_page.dart';

class DeviceTile extends StatefulWidget {
  // final Device device;
  final void Function()? onTap;
  // final String docId;
  // const DeviceTile({super.key, required this.device, required this.onTap});
  const DeviceTile({super.key,  this.onTap});

  @override
  State<DeviceTile> createState() => _DeviceTileState();
}

class _DeviceTileState extends State<DeviceTile> {
  final Stream<QuerySnapshot> _deviceStream =
      FirebaseFirestore.instance.collection('device').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _deviceStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Column(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> device =
                document.data()! as Map<String, dynamic>;
             // Get the document ID
            // String docId = document.id;
            // print("Document ID: $docId");
            return GestureDetector(
              onTap: () {
                // Extract the document ID from the snapshot
    String docId = document.id;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeviceDetailsPage(docId: docId),
      ),
    );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                padding: const EdgeInsets.all(25),
               
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // image
                        Image.asset(
                          "lib/images/home/watering-plants(2).png",
                          height: 60,
                        ),

                        const SizedBox(
                          width: 25,
                        ),

                        // name and zone
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //name
                            Text(
                              device["name"],
                              style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // _price
                            Text(
                              device["zone"],
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // heart
                    Icon(Icons.push_pin_outlined, color: Colors.grey, size: 20),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );

   
  }
}
