import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watering_plants/components/button.dart';
import 'package:watering_plants/components/sleek_circular_slider.dart';
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
  double barometricPressure = 0;
  double _temperature = 0;
  double _humidity = 0;
  double _tvoc = 0;
  double _co2 = 0;

  void _onBarometricPressureChange(double value) {
    setState(() {
      barometricPressure = value;
    });
  }

  void _onTemperatureChange(double value) {
    setState(() {
      _temperature = value;
    });
  }

  void _onHumidityChange(double value) {
    setState(() {
      _humidity = value;
    });
  }

  void _onTvocChange(double value) {
    setState(() {
      _tvoc = value;
    });
  }

  void _onCo2Change(double value) {
    setState(() {
      _co2 = value;
    });
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
        title: Text(widget.device.name + " - " + widget.device.zone),
        backgroundColor: primaryColor,
        // elevation: 0,
        // foregroundColor: Colors.grey[900], // to see the back icon
      ),
      body: Column(
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
                  MySwitch()
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
                        Text("Barometric Pressure"),

                        const SizedBox(
                          height: 10,
                        ),

                        // device zone

                        MySleekCircularSlider(
                          min: 142.0,
                          max: 1017.0,
                          initialValue: widget.device.barometricPressure,
                          unit: widget.device.unite["barometricPressure"]!,
                          trackColor: Colors.grey,
                          progressBarColors: [primaryColor, secondaryColor],
                          // topLabelText: 'running...',
                          onChange: _onBarometricPressureChange,
                        ),

                        Container(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("142"), Text("1017")],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // device name
                        Text("Temperature"),

                        const SizedBox(
                          height: 10,
                        ),

                        // device zone
                        MySleekCircularSlider(
                          min: 0.0,
                          max: 40.0,
                          initialValue: widget.device.temperature,
                          unit: widget.device.unite["temperature"]!,
                          trackColor: Colors.grey,
                          progressBarColors: [primaryColor, secondaryColor],
                          // topLabelText: 'running...',
                          onChange: _onTemperatureChange,
                        ),

                        Container(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("0"), Text("40")],
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

              // humidity and co2 container
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
                        Text("Humidity"),

                        const SizedBox(
                          height: 10,
                        ),

                        // device zone

                        MySleekCircularSlider(
                          min: 0.0,
                          max: 100.0,
                          initialValue: widget.device.humidity,
                          unit: widget.device.unite["humidity"]!,
                          trackColor: Colors.grey,
                          progressBarColors: [primaryColor, secondaryColor],
                          // topLabelText: 'running...',
                          onChange: _onHumidityChange,
                        ),

                        Container(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("0"), Text("100")],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // device name
                        Text("CO2"),

                        const SizedBox(
                          height: 10,
                        ),

                        // device zone
                        MySleekCircularSlider(
                          min: 812.0,
                          max: 2200.0,
                          initialValue: widget.device.co2,
                          unit: widget.device.unite["co2"]!,
                          trackColor: Colors.grey,
                          progressBarColors: [primaryColor, secondaryColor],
                          // topLabelText: 'running...',
                          onChange: _onCo2Change,
                        ),

                        Container(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("0"), Text("100")],
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
              // tvoc container
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // device name
                      Text("TVOC"),

                      const SizedBox(
                        height: 10,
                      ),

                      // device zone
                      MySleekCircularSlider(
                        min: 405,
                        max: 1340.0,
                        initialValue: widget.device.tvoc,
                        unit: widget.device.unite["tvoc"]!,
                        trackColor: Colors.grey,
                        progressBarColors: [primaryColor, secondaryColor],
                        // topLabelText: 'running...',
                        onChange: _onTvocChange,
                      ),

                      Container(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("405"), Text("1340")],
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
                      MyButton(text: "View Schedule", onTap: viewSchedule),
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
