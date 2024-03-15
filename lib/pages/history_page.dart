import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watering_plants/components/device_tile.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/pages/add_schedule_page.dart';
import 'package:watering_plants/theme/colors.dart';

class HistoryPage extends StatefulWidget {
  // final Device device;
  // final String deviceKey;
  const HistoryPage({
    super.key,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DatabaseReference _databaseReferenceDeviceInfos =
      FirebaseDatabase.instance.ref();

  TextEditingController deviceKeyController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final String deviceKeyValue = "";

  @override
  void initState() {
    super.initState();

    _databaseReferenceDeviceInfos = _databaseReferenceDeviceInfos
        .child('UsersData')
        .child(currentUser!.uid)
        .child('readings');
    // print(_databaseReferenceDeviceInfos);
  }


  //  (receiving data)

  @override
  Widget build(BuildContext context) {
    final deviceKey = ModalRoute.of(context)!.settings.arguments.toString();
    // print(deviceKey); //{deviceKey: 1710231412877}
    final deviceKeyValue = deviceKey.replaceAll(RegExp("{|}|deviceKey: "), "");
    deviceKeyValue.trim();
    // print(deviceKeyValue); //1710231412877
//     final deviceKeyValue = deviceKeyList.split(','); // [webfun,  subscribe}]
// print(deviceKeyValue);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          "Schedule",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: FirebaseAnimatedList(
          query: _databaseReferenceDeviceInfos,
          shrinkWrap: true,
          itemBuilder: (context, snapshot, animation, index) {
            DatabaseReference scheduleInfos = FirebaseDatabase.instance
                .ref()
                .child('UsersData')
                .child(currentUser!.uid)
                .child('readings/${snapshot.key}')
                .child("history");

            return (snapshot.key == deviceKeyValue)
                ? Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    margin:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                    padding: const EdgeInsets.all(10),
                    child: // date
                        Column(
                      children: [
                        Center(
                          
                            child: FirebaseAnimatedList(
                                query: scheduleInfos,
                                shrinkWrap: true,
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  // print(snapshot.key);
                                  // print(snapshot.value);
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => DeviceDetailsPage(docId: docId),
                                      //   ),
                                      // );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin: const EdgeInsets.only( bottom: 15),
                                      // padding: const EdgeInsets.all(5),
                                      child:
                                          // name and zone
                                          Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          //name
                                          Text(
                                            snapshot.child("date")
                                                .value
                                                .toString(),
                                            style: GoogleFonts.dmSerifDisplay(
                                                fontSize: 18),
                                          ),

                                          const SizedBox(
                                            height: 5,
                                          ),

                                          // _price
                                          // Text(
                                          //   snapshot
                                          //       .child("wateringTime")
                                          //       .value
                                          //       .toString(),
                                          //   style: TextStyle(
                                          //       color: Colors.white),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );

                                  // Container(
                                  //   child: Column(children: [
                                  //     Text(snapshot.child("wateringDate").value.toString()),
                                  //     Text(snapshot.child("wateringTime").value.toString()),
                                  //   ],),
                                  // );
                                })

                            // Text(
                            //   // DateTime.fromMillisecondsSinceEpoch(int.parse(
                            //   //         snapshot
                            //   //             .child("timestamps")
                            //   //             .value
                            //   //             .toString()))
                            //   //     .toString(),
                            //   snapshot.child("wateringDate").toString(),
                            //   style: TextStyle(color: Colors.white, fontSize: 20),
                            // ),
                            ),
                        SizedBox(
                          width: 1,
                          height: 0.0001,
                          child: TextField(
                            controller: deviceKeyController
                              ..text = snapshot.key.toString(),
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                // )
                : SizedBox(
                    height: 0.00000000000000000000001,
                  );
          }),
    );
  }
}
