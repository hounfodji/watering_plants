class Device {
  String name;
  String zone;
  String imagePath;
  double barometricPressure;
  double temperature;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
  double humidity;
  double co2;
  double tvoc;


  Device({
    required this.name,
    required this.zone,
    required this.imagePath,
    required this.barometricPressure,
    required this.temperature,
    required this.humidity,
    required this.co2,
    required this.tvoc,
  });

  String get _name => name;
  String get _zone => zone;
  String get _imagePath => imagePath;
  double get _barometricPressure => barometricPressure;
  double get _temperature => temperature;
  double get _co2 => co2;
  double get _tvoc => tvoc;

  
}