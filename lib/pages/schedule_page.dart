import 'package:flutter/material.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/theme/colors.dart';

class SchedulePage extends StatefulWidget {
  // final Device device;
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  void addSchedule() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("Schedule"),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: addSchedule,
          child: const Icon(Icons.add)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: ((context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListTile(
                  title: Text(
                    "12-02-2024",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "00:10",
                    style: TextStyle(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              );
            })),
          )
        ],
      ),
    );
  }
}
