import 'package:flutter/material.dart';

// display err ors to user
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text(message),
          )));
}
