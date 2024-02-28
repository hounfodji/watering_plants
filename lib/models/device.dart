import 'package:intl/intl.dart';

class Device {
  String name;
  String zone;
  String imagePath;
  DateTime date; // Stores both date and time
  double barometricPressure;
  double temperature;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
  double humidity;
  double co2;
  double tvoc;
  final Map<String, String> unite; // les unités de mesure
  final Map<String, List<int>> minMaxValue; //for min max value

  Device({
    required this.name,
    required this.zone,
    required this.imagePath,
    required this.date,
    required this.barometricPressure,
    required this.temperature,
    required this.humidity,
    required this.co2,
    required this.tvoc,

    Map<String, String>? unite,
    Map<String, List<int>>? minMaxValue,
  }): unite = unite ?? {},
      minMaxValue = minMaxValue ?? {};

  String get _name => name;
  String get _zone => zone;
  String get _imagePath => imagePath;
  // New getter for formatted date string:
  String get formattedDate {
    return DateFormat('EEE d MMM yyyy').format(date); // Custom format based on feedback
  }
   // New getter for formatted time string:
  String get formattedHour {
    return DateFormat('h:mma').format(date); // 12-hour format with am/pm
  }
  double get _barometricPressure => barometricPressure;
  double get _temperature => temperature;
  double get _co2 => co2;
  double get _tvoc => tvoc;

  
}