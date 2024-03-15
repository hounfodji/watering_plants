import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/theme/colors.dart';

class AddSchedulePage extends StatefulWidget {
  // final  devicekey; // Add a field to receive the variable

  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceKey = ModalRoute.of(context)!.settings.arguments.toString();
    // print(deviceKey);
    final deviceKeyValue = deviceKey.replaceAll(RegExp("{|}|deviceKey: "), "");
    deviceKeyValue.trim();
    var dTime = DateTime.now().millisecondsSinceEpoch.toString();

    // final ref = fb.ref().child('todos/$k');
    final User? currentUser = FirebaseAuth.instance.currentUser;
    DatabaseReference databaseReferenceDeviceInfos = FirebaseDatabase.instance
        .ref()
        .child('UsersData')
        .child(currentUser!.uid)
        .child("readings")
        .child(dTime);
//         print("bon");
// print(deviceKeyValue);

          updateDeviceStatut(String deviceKey, String dateText, String timeText) async {
final User? currentUser = FirebaseAuth.instance.currentUser;
var dTime = DateTime.now().millisecondsSinceEpoch.toString();
    DatabaseReference databaseReferenceDeviceInfos =
        FirebaseDatabase.instance.ref().child('UsersData')
        .child(currentUser!.uid)
        .child('readings/$deviceKey/schedule');

// Only update the name, leave the age and address!
    await databaseReferenceDeviceInfos.update({
      dTime : {
        "wateringDate" : dateText,
        "wateringTime" : timeText,
      }
    });
    
  }

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            "Add Schedule",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    controller:
                        dateinput, //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: timeinput,
                    decoration: InputDecoration(
                      icon: Icon(Icons.access_time), // Time icon
                      labelText: "Enter Time",
                    ),
                    readOnly: true, // Make time input read-only
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime:
                            TimeOfDay.now(), // Assuming selectedTime is defined
                        context: context,
                      );

                      if (pickedTime != null) {
                        setState(() {
                          timeinput.text = pickedTime!.format(context);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: secondaryColor),
                onPressed: () {
                  updateDeviceStatut(deviceKeyValue, dateinput.text, timeinput.text);

                    

                  Navigator.pop(context);
                },
                child: const Text("Add"))
                ],
              ),
            )
            )
            );
  }
}
