import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watering_plants/components/button.dart';
import 'package:watering_plants/components/switch.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/theme/colors.dart';

class DeviceDetailsPage extends StatefulWidget {
  final Device device;
  const DeviceDetailsPage({super.key, required this.device});

  @override
  State<DeviceDetailsPage> createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.grey[900], // to see the back icon
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Container(
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // device name
                      Text(widget.device.name,
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 20,
                            color: Colors.white,
                          )),

                      const SizedBox(
                        height: 20,
                      ),

                      // device zone
                      Text(widget.device.zone,
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    ],
                  ),

                  // device Image
                  Image.asset(
                    "lib/images/home/watering.png",
                    height: 90,
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),

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
                MySwitch()
              ],
            ),
        ],),
    );
  }
}