import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watering_plants/models/device.dart';

class DeviceTile extends StatelessWidget {
  final Device device;
  final void Function()? onTap;
  const DeviceTile({super.key, required this.device, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
        padding: const EdgeInsets.all(25),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     // name
        //    Text(
        //       device.name,
        //       style: TextStyle(
        //         color: Colors.grey[900],
        //         fontSize: 20,
        //       ),
        //     ),
    
        //     // text
        //     Text(
        //       device.zone,
        //       style: GoogleFonts.dmSerifDisplay(fontSize: 20),
        //     ),
    
    
           
        //   ],
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                 // image
                    Image.asset(
                      device.imagePath,
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
                            device.name,
                            style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                          ),
    
                          const SizedBox(
                            height: 10,
                          ),
    
                          // _price
                          Text(
                            device.zone,
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

  }
}
