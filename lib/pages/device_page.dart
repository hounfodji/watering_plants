import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watering_plants/components/button.dart';
import 'package:watering_plants/components/device_tile.dart';
import 'package:watering_plants/components/my_drawer.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/models/device_list.dart';
import 'package:watering_plants/pages/add_device.dart';
import 'package:watering_plants/pages/device_details_page.dart';
import 'package:watering_plants/theme/colors.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  void addDevice() {
    // Navigator.pushNamed(context, "/adddevicepage");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return const AddDevicePage();
        },
        fullscreenDialog: true));
  }

    void goToDeviceDetail() {
    Navigator.pushNamed(context, "/devicedetailpage");
   
  }

  // navigate to device details page****************************************************
  // void navigateDetailsPage(int index) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => DeviceDetailsPage(
  //         device: deviceList[index],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // leading: Icon(
          //   Icons.menu,
          //   color: Colors.grey[900],
          // ),
          title: Text(
            "Cotonou",
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 20,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // promo banner
            Container(
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // promo message
                      Text("Water needed at zone A",
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 15,
                            color: Colors.white,
                          )),

                      const SizedBox(
                        height: 20,
                      ),

                      // watering button
                      MyButton(
                        text: "Watering",
                        onTap: () {},
                      )
                    ],
                  ),

                  // Image
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

            // search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Search device.."),
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // Device list
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "All devices",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 18),
                  ),
                ),

                // Add device
                MyButton(text: "Add", onTap: addDevice),
              ],
            ),

            // button to add a device

            const SizedBox(
              height: 25,
            ),

            //   ListView.builder(
            //     itemCount: 50,
            //     itemBuilder: (context, id) {
            //       return ListTile(
            //         leading: Icon(Icons.add_box),
            //         title: Text("Item $id"),
            //       );
            //     }
            //   ),

            Expanded(
                child: ListView(
              children: [DeviceTile()],
            ))
          ],
        ),
        drawer: MyDrawer());
  }
}
