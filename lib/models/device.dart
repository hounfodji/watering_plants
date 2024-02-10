class Device {
  String name;
  String zone;
  String imagePath;


  Device({
    required this.name,
    required this.zone,
    required this.imagePath,
  });

  String get _name => name;
  String get _zone => zone;
  String get _imagePath => imagePath;
}