import 'package:flutter/material.dart';
import 'package:watering_plants/models/device.dart';
import 'package:watering_plants/theme/colors.dart';

class HistoryPage extends StatefulWidget {
  // final Device device;
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  void addSchedule() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
     
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
