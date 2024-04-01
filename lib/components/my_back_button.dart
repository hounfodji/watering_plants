import 'package:flutter/material.dart';
import 'package:watering_plants/theme/colors.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.arrow_back,
          color: secondaryColor,
        ),
      ),
    );
  }
}
