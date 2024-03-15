import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watering_plants/components/button.dart';
import 'package:watering_plants/components/sleek_circular_slider.dart';
import 'package:watering_plants/components/switch.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/pages/schedule_page.dart';
import 'package:watering_plants/theme/colors.dart';

class DeviceDetailsPage extends StatefulWidget {
  final String docId;
  
  const DeviceDetailsPage({super.key, required this.docId});

  @override
  State<DeviceDetailsPage> createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  int _count = 1; // for history
  Stream<DocumentSnapshot?> _deviceStream = Stream.empty();
  DatabaseReference _databaseReferenceDeviceInfos =
      FirebaseDatabase.instance.ref();

  final User? currentUser = FirebaseAuth.instance.currentUser;

  double temperature = 0.0;
  double humidity = 0.0;
  double barometricPressure = 0.0;
  double tvoc = 0.0;
  double co2 = 0.0;

  final deviceKey = "";
  var dTime = DateTime.now().millisecondsSinceEpoch.toString();
  TextEditingController deviceKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _deviceStream = FirebaseFirestore.instance
        .collection('device')
        .doc(widget.docId)
        .snapshots();

    _databaseReferenceDeviceInfos = _databaseReferenceDeviceInfos
        .child('UsersData')
        .child(currentUser!.uid)
        .child('devices');
    print(_databaseReferenceDeviceInfos.key);
  }





    updateDeviceStatut(String deviceKey, bool deviceStatut) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    DatabaseReference databaseReferenceDeviceInfos =
        FirebaseDatabase.instance.ref().child('UsersData')
        .child(currentUser!.uid)
        .child('readings/$deviceKey');
        final dStat = !deviceStatut;

// Only update the name, leave the age and address!
    await databaseReferenceDeviceInfos.update({
      "deviceStatut": dStat,
    });

    if(dStat) {
                                                    await databaseReferenceDeviceInfos.child("history")
                                                    .update({
      DateTime.now().microsecond.toString() : {
        "date" : DateTime.now().toString(),
      }
    });
    
 _count ++;
                                                  }
  }




  void viewSchedule() {
    Navigator.pushNamed(context, "/schedulepage", arguments: {'deviceKey': deviceKeyController.text});
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SchedulePage(deviceKey: deviceKey),
    //   ),
    // );
  }

  void viewHistory() {
    Navigator.pushNamed(context, "/historypage", arguments: {'deviceKey': deviceKeyController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot?>(
          stream: _deviceStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error fetching device details: ${snapshot.error}");
              return Text("Error: ${snapshot.error}");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }

            final deviceData = snapshot.data!.data()! as Map<String, dynamic>;
            return Text(
              deviceData["name"] + " (" + deviceData["zone"] + ")",
              style: TextStyle(color: Colors.white),
            );
          },
        ),
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder<DocumentSnapshot?>(
        stream: _deviceStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error fetching device details: ${snapshot.error}");
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final deviceData = snapshot.data!.data()! as Map<String, dynamic>;
          // print(deviceData["name"]);

          return Container(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0.0, // Pin the bottom edge to 0.0
                  left: 0.0, // Pin the left edge to 0.0 for full width
                  right: 0.0, // Pin the right edge to 0.0 for full width
                  child: FirebaseAnimatedList(
                      query: _databaseReferenceDeviceInfos,
                      shrinkWrap: true,
                      itemBuilder: (context, snapshot, animation, index) {
                        print(snapshot.child("pompe").value);
                        // print(widget.docId);
                        // print(snapshot.child("name").value);
                        // print(
                        //     deviceData["name"] == snapshot.child("name").value);
                        // snapshot.child(widget.docId).child("minMaxValue");

                        return 
                        
                        // (deviceData["name"] ==
                        //         snapshot.child("name").value)
                        //     ? 
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                     
                                      // barometric pressure and temperature
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // barometric pressure

                                            Column(
                                              children: [
                                                // device name
                                                Text(
                                                  "Barometric Pressure",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                //device zone
                                                //******************************************************************************************************** */
                                                MySleekCircularSlider(
                                                  min: deviceData["minMaxValue"]
                                                          [
                                                          "barometricPressure"][0]
                                                      .toDouble(),
                                                  max: deviceData["minMaxValue"]
                                                          [
                                                          "barometricPressure"][1]
                                                      .toDouble(),
                                                  initialValue:
                                                      // deviceData["barometricPressure"].toDouble(),
                                                      snapshot
                                                          .child(
                                                              "barometricPressure")
                                                          .value as double,
                                                  unit: deviceData["unite"]
                                                      ["barometricPressure"],
                                                  trackColor: Colors.white,
                                                  progressBarColors: [
                                                    Color.fromARGB(
                                                        255, 97, 190, 61),
                                                    Color.fromARGB(
                                                        255, 5, 235, 77)
                                                  ],
                                                  // topLabelText: 'running...',
                                                  onChange: (value) {},
                                                ),

                                                Container(
                                                  width: 120,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    //******************************************************************* */
                                                    children: [
                                                      Text(
                                                        deviceData["minMaxValue"]
                                                                [
                                                                "barometricPressure"][0]
                                                            .toString(),
                                                      ),
                                                      Text(
                                                        deviceData["minMaxValue"]
                                                                [
                                                                "barometricPressure"][1]
                                                            .toString(),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),

                                            //temperature
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // device name
                                                Text(
                                                  "Temperature",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                // device zone
                                                MySleekCircularSlider(
                                                  min: deviceData["minMaxValue"]
                                                          ["temperature"]![0]
                                                      .toDouble(),
                                                  max: deviceData["minMaxValue"]
                                                          ["temperature"]![1]
                                                      .toDouble(),
                                                  initialValue:
                                                      // deviceData["temperature"].toDouble(),
                                                      snapshot
                                                          .child("temperature")
                                                          .value as double,
                                                  unit: deviceData["unite"]
                                                      ["temperature"],
                                                  trackColor: Colors.white,
                                                  progressBarColors: [
                                                    Color.fromARGB(
                                                        255, 221, 218, 163),
                                                    Color.fromARGB(
                                                        255, 236, 232, 163)
                                                  ],
                                                  // topLabelText: 'running...',
                                                  onChange: (value) {},
                                                ),

                                                Container(
                                                  width: 120,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(deviceData[
                                                                  "minMaxValue"]
                                                              [
                                                              "temperature"]![0]
                                                          .toString()),
                                                      Text(deviceData[
                                                                  "minMaxValue"]
                                                              [
                                                              "temperature"]![1]
                                                          .toString())
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 25,
                                      ),

                                      // humidity and tvoc container
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // device name
                                                Text(
                                                  "Humidity",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                // device zone

                                                MySleekCircularSlider(
                                                  min: deviceData["minMaxValue"]
                                                          ["humidity"]![0]
                                                      .toDouble(),
                                                  max: deviceData["minMaxValue"]
                                                          ["humidity"]![1]
                                                      .toDouble(),
                                                  initialValue:
                                                      // deviceData["humidity"].toDouble(),
                                                      snapshot
                                                          .child("humidity")
                                                          .value as double,
                                                  unit: deviceData["unite"]
                                                      ["humidity"],
                                                  trackColor: Colors.white,
                                                  progressBarColors: [
                                                    const Color.fromARGB(
                                                        255, 104, 178, 238),
                                                    Color.fromARGB(
                                                        255, 63, 161, 242)
                                                  ],
                                                  // topLabelText: 'running...',
                                                  onChange: (value) {},
                                                ),

                                                Container(
                                                  width: 120,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(deviceData[
                                                                  "minMaxValue"]
                                                              ["humidity"]![0]
                                                          .toString()),
                                                      Text(deviceData[
                                                                  "minMaxValue"]
                                                              ["humidity"]![1]
                                                          .toString())
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),

                                            // tvoc
                                            Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // device name
                                              Text(
                                                "TVOC",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ),

                                              // device zone
                                              MySleekCircularSlider(
                                                min: deviceData["minMaxValue"]
                                                        ["tvoc"]![0]
                                                    .toDouble(),
                                                max: deviceData["minMaxValue"]
                                                        ["tvoc"]![1]
                                                    .toDouble(),
                                                initialValue:
                                                    //  deviceData["tvoc"].toDouble(),
                                                    snapshot.child("tvoc").value
                                                        as double,
                                                unit: deviceData["unite"]
                                                    ["tvoc"],
                                                trackColor: Colors.white,
                                                progressBarColors: [
                                                  const Color.fromARGB(
                                                      255, 198, 95, 88),
                                                  Color.fromARGB(
                                                      255, 193, 83, 75)
                                                ],
                                                // topLabelText: 'running...',
                                                onChange: (value) {},
                                              ),

                                              Container(
                                                width: 120,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(deviceData[
                                                                "minMaxValue"]
                                                            ["tvoc"]![0]
                                                        .toString()),
                                                    Text(deviceData[
                                                                "minMaxValue"]
                                                            ["tvoc"]![1]
                                                        .toString())
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),

                                            // co2
                                            // Column(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.center,
                                            //   children: [
                                            //     // device name
                                            //     Text(
                                            //       "CO2",
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.bold,
                                            //           color: Colors.white),
                                            //     ),

                                            //     const SizedBox(
                                            //       height: 10,
                                            //     ),

                                            //     // device zone
                                            //     MySleekCircularSlider(
                                            //       min: deviceData["minMaxValue"]
                                            //               ["co2"]![0]
                                            //           .toDouble(),
                                            //       max: deviceData["minMaxValue"]
                                            //               ["co2"]![1]
                                            //           .toDouble(),
                                            //       initialValue:
                                            //           // deviceData["co2"].toDouble(),
                                            //           snapshot
                                            //               .child("co2")
                                            //               .value as double,
                                            //       unit: deviceData["unite"]
                                            //           ["co2"],
                                            //       trackColor: Colors.white,
                                            //       progressBarColors: [
                                            //         Color.fromARGB(
                                            //             255, 246, 229, 79),
                                            //         Color.fromARGB(
                                            //             255, 248, 228, 49)
                                            //       ],
                                            //       // topLabelText: 'running...',
                                            //       onChange: (value) {},
                                            //     ),

                                            //     Container(
                                            //       width: 120,
                                            //       child: Row(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment
                                            //                 .spaceBetween,
                                            //         children: [
                                            //           Text(deviceData[
                                            //                       "minMaxValue"]
                                            //                   ["co2"]![0]
                                            //               .toString()),
                                            //           Text(deviceData[
                                            //                       "minMaxValue"]
                                            //                   ["co2"]![1]
                                            //               .toString())
                                            //         ],
                                            //       ),
                                            //     )
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // switch and buttons for schedule and history
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFCFDF7),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        // switch
                                        Row(
                                          
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 1,
                                                    child: TextField(
                                                      controller: deviceKeyController..text = snapshot.key.toString(),
                                                      readOnly: true,
                                                      enabled: false,
                                                      decoration: InputDecoration(border: InputBorder.none,),
                                                    ),
                                                  ),
                                                  Text(
                                                    "On/Off device",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey[800],
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            //On/Off
                                            Switch(
                                              activeColor: Colors.white,
                                              activeTrackColor: secondaryColor,
                                              // value: deviceData["deviceStatut"],
                                              value: snapshot.child("deviceStatut").value as bool,
                                              // snapshot
                                              //     .child("deviceStatut")
                                              //     .value as bool,
                                              onChanged: (newValue) async {
                                                try {
                                                //   await FirebaseFirestore
                                                //       .instance
                                                //       .collection("device")
                                                //       .doc(widget.docId)
                                                //       .update({
                                                //     "deviceStatut": newValue
                                                // });
                                                //   // Update UI based on the new value
                                                //   setState(() {
                                                //     deviceData["deviceStatut"] =
                                                //         newValue;
                                                //   });
                                                  updateDeviceStatut(snapshot.key as String, snapshot.child("deviceStatut").value as bool);

                                                  print(snapshot.child("deviceStatut").value as bool);
    //                                               if(snapshot.child("deviceStatut").value as bool) {
    //                                                 await _databaseReferenceDeviceInfos.child(snapshot.key as String)
    //                                                 .update({
    //   "history": DateTime.now().millisecondsSinceEpoch.toString(),
    // });
    //                                               }

                                                  print(
                                                      "Switch state updated successfully:");
                                                } catch (e) {
                                                  // Handle errors appropriately
                                                  print(
                                                      "Error updating switch state: $e");
                                                }
                                              },
                                            ),
                                            // MySwitch(
                                            //   light: deviceData["deviceStatut"],
                                            // )
                                          ],
                                        ),
                                        // buttons for view schedule and history
                                        Container(
                                          // color: primaryColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    MyButton(
                                                        text: "View Schedule",
                                                        onTap: viewSchedule),
                                                    MyButton(
                                                        text: "View History",
                                                        onTap: viewHistory),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                                
                              )
                              
                            // : SizedBox(
                            //     height: 0.00000000000000000000001,
                            //   )
                              ;
                      }),
                ),
              ],
            ),
          );
        },
      ),
      // backgroundColor: Color.fromARGB(255, 59, 113, 157),
      backgroundColor: primaryColor,
    );
  }
}
