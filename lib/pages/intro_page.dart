import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watering_plants/components/button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 95, 149, 59),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 15,
            ),

            // shop name
            Text(
              "GrowGreen",
              style:
                  GoogleFonts.dmSerifDisplay(fontSize: 28, color: Colors.white),
            ),

            const SizedBox(height: 15),
            // icon
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("lib/images/home/watering-plants.png"),
            ),

            const SizedBox(height: 15),

            // title
            Text(
              "EFORTLESS GARDERING MADE POSSIBLE",
              style:
                  GoogleFonts.dmSerifDisplay(fontSize: 34, color: Colors.white),
            ),

            const SizedBox(height: 10),

            // subtitle
            Text(
              "Save water, save time, grow beautiful plants.",
              style:
                  TextStyle(color: Colors.grey[300], height: 2, fontSize: 17),
            ),

            const SizedBox(height: 15),

            // get started bottom
            MyButton(
              text: "Get Started",
              onTap: () {
                // go to list device page
                Navigator.pushNamed(context, "/auth_page");
              },
            )
          ],
        ),
      ),
    );
  }
}
