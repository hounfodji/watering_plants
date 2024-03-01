import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watering_plants/components/button.dart';
import 'package:watering_plants/components/sleek_circular_slider.dart';
import 'package:watering_plants/components/switch.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/theme/colors.dart';

class DeviceDetailsPage extends StatefulWidget {
  // final Device device;
  // const DeviceDetailsPage({super.key, required this.device});
  final String docId;
  const DeviceDetailsPage({super.key, required this.docId});

  @override
  State<DeviceDetailsPage> createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  // double _barometricPressure = 0;
  // double _temperature = 0;
  // double _humidity = 0;
  // double _tvoc = 0;
  // double _co2 = 0;

  // void _onBarometricPressureChange(double value) {
  //   setState(() {
  //     _barometricPressure = value;
  //   });
  // }

  // void _onTemperatureChange(double value) {
  //   setState(() {
  //     _temperature = value;
  //   });
  // }

  // void _onHumidityChange(double value) {
  //   setState(() {
  //     _humidity = value;
  //   });
  // }

  // void _onTvocChange(double value) {
  //   setState(() {
  //     _tvoc = value;
  //   });
  // }

  // void _onCo2Change(double value) {
  //   setState(() {
  //     _co2 = value;
  //   });
  // }

  // Device data
  Map<String, dynamic>? _deviceData;
  bool _isDeviceLoading = true; // Flag to indicate data loading state

  // Removed unused variables and functions

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchDeviceDetails(widget.docId); // Fetch data and update state
  }

  Future<Map<String, dynamic>?> _fetchDeviceDetails(String docId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection("device").doc(docId).get();
      if (documentSnapshot.exists) {
        setState(() {
          _deviceData = documentSnapshot.data()! as Map<String, dynamic>;
          _isDeviceLoading = false; // Data loaded, update loading state
        });
        return _deviceData;
      } else {
        print("Device with ID $docId not found");
        return null;
      }
    } catch (error) {
      print("Error fetching device details: $error");
      return null;
    }
  }

  void viewSchedule() {
    Navigator.pushNamed(context, "/schedulepage");
  }

  void viewHistory() {
    Navigator.pushNamed(context, "/historypage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //************************************************************************************************* */
        title: _isDeviceLoading
            ? const Text("Loading...")
            : Text(_deviceData!["name"] + " (" + _deviceData!["zone"] + ")"),
        backgroundColor: primaryColor,
        // elevation: 0,
        // foregroundColor: Colors.grey[900], // to see the back icon
      ),
      body: _isDeviceLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Display loading indicator while data is fetched
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // container for details
                Column(
                  children: [
                    // device's status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            "On/Off device",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontSize: 18),
                          ),
                        ),

                        //On/Off
                        MySwitch(light: _deviceData!["deviceStatut"],)
                        
                      ],
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    // barometric pressure and teperature container
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // device name
                              Text(
                                "Barometric Pressure",    
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              //device zone
                              //******************************************************************************************************** */
                              MySleekCircularSlider(
                                min: _deviceData!["minMaxValue"]["barometricPressure"][0].toDouble(),
                                max:  _deviceData!["minMaxValue"]["barometricPressure"][1].toDouble(),
                                initialValue: _deviceData!["barometricPressure"].toDouble(),
                                unit: _deviceData!["unite"]["barometricPressure"],
                                trackColor: Colors.grey,
                                progressBarColors: [Color.fromARGB(255, 97, 190, 61), Color.fromARGB(255, 5, 235, 77)],
                                // topLabelText: 'running...',
                                onChange:(value) {
                                  
                                },
                              ),

                              Container(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //******************************************************************* */
                                  children: [
                                    Text( _deviceData!["minMaxValue"]["barometricPressure"][0]
                                        .toString()),
                                    Text( _deviceData!["minMaxValue"]["barometricPressure"][1]
                                        .toString())
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                          // temperature
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // device name
                              Text("Temperature", style: TextStyle(fontWeight: FontWeight.bold),),

                              const SizedBox(
                                height: 10,
                              ),

                              // device zone
                              MySleekCircularSlider(
                                min:  _deviceData!["minMaxValue"]["temperature"]![0]
                                    .toDouble(),
                                max:  _deviceData!["minMaxValue"]["temperature"]![1]
                                    .toDouble(),
                                initialValue: _deviceData!["temperature"].toDouble(),
                                unit: _deviceData!["unite"]["temperature"],
                                trackColor: Colors.grey,
                                progressBarColors: [Color.fromARGB(255, 221, 218, 163), Color.fromARGB(255, 236, 232, 163)],
                                // topLabelText: 'running...',
                                onChange:(value) {
                                  
                                },
                              ),

                              Container(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_deviceData!["minMaxValue"]["temperature"]![0]
                                        .toString()),
                                    Text(_deviceData!["minMaxValue"]["temperature"]![0]
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

                    //humidity and co2 container
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // device name
                              Text("Humidity", style: TextStyle(fontWeight: FontWeight.bold),),

                              const SizedBox(
                                height: 10,
                              ),

                              // device zone

                              MySleekCircularSlider(
                                min: _deviceData!["minMaxValue"]["humidity"]![0]
                                    .toDouble(),
                                max: _deviceData!["minMaxValue"]["humidity"]![1]
                                    .toDouble(),
                                initialValue:  _deviceData!["humidity"].toDouble(),
                                unit: _deviceData!["unite"]["humidity"],
                                trackColor: Colors.grey,
                                progressBarColors: [const Color.fromARGB(255, 104, 178, 238), Color.fromARGB(255, 63, 161, 242)],
                                // topLabelText: 'running...',
                                onChange:(value) {
                                  
                                },
                              ),

                              Container(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_deviceData!["minMaxValue"]["humidity"]![0]
                                        .toString()),
                                    Text(_deviceData!["minMaxValue"]["humidity"]![1]
                                        .toString())
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                          // co2
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // device name
                              Text("CO2", style: TextStyle(fontWeight: FontWeight.bold),),

                              const SizedBox(
                                height: 10,
                              ),

                              // device zone
                              MySleekCircularSlider(
                                min: _deviceData!["minMaxValue"]["co2"]![0].toDouble(),
                                max: _deviceData!["minMaxValue"]["co2"]![1].toDouble(),
                                initialValue:  _deviceData!["co2"].toDouble(),
                                unit: _deviceData!["unite"]["co2"],
                                trackColor: Colors.grey,
                                progressBarColors: [Color.fromARGB(255, 246, 229, 79), Color.fromARGB(255, 248, 228, 49)],
                                // topLabelText: 'running...',
                                onChange:(value) {
                                  
                                },
                              ),

                              Container(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_deviceData!["minMaxValue"]["co2"]![0]
                                        .toString()),
                                    Text(_deviceData!["minMaxValue"]["co2"]![1]
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
                    //tvoc container
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // device name
                            Text("TVOC", style: TextStyle(fontWeight: FontWeight.bold),),

                            const SizedBox(
                              height: 10,
                            ),

                            // device zone
                            MySleekCircularSlider(
                              min: _deviceData!["minMaxValue"]["tvoc"]![0].toDouble(),
                              max: _deviceData!["minMaxValue"]["tvoc"]![1].toDouble(),
                              initialValue:  _deviceData!["tvoc"].toDouble(),
                              unit: _deviceData!["unite"]["tvoc"],
                              trackColor: Colors.grey,
                              progressBarColors: [const Color.fromARGB(255, 198, 95, 88), Color.fromARGB(255, 193, 83, 75)],
                              // topLabelText: 'running...',
                             onChange:(value) {
                                  
                                },
                            ),

                            Container(
                              width: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_deviceData!["minMaxValue"]["tvoc"]![0]
                                      .toString()),
                                  Text(_deviceData!["minMaxValue"]["tvoc"]![1]
                                      .toString())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // buttons for view schedule and history
                Container(
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      children: [
                        // price + quantity
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyButton(
                                text: "View Schedule", onTap: viewSchedule),
                            MyButton(text: "View History", onTap: viewHistory),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
