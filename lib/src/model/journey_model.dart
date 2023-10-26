class Journey {
  String name;
  String empCode;
  String tName;
  String leadName;
  String pickPoint;
  String driverName;
  String dNumber;
  String vehicleNumber;
  String vType;
  String odoImage;
  String odoReading;
  String startJourney;
  String endJourney;
  String longitude;
  String latitude;
  Journey(
      {required this.name,
      required this.empCode,
      required this.tName,
      required this.leadName,
      required this.pickPoint,
      required this.driverName,
      required this.dNumber,
      required this.vehicleNumber,
      required this.vType,
      required this.odoImage,
      required this.odoReading,
      required this.startJourney,
      required this.endJourney,
      required this.longitude,
      required this.latitude});

  factory Journey.fromJson(Map<String, dynamic> json) => Journey(
      name: json['name'],
      empCode: json['empCode'],
      tName: json['tName'],
      leadName: json['leadName'],
      pickPoint: json['pickPoint'],
      driverName: json['driverName'],
      dNumber: json['dNumber'],
      vehicleNumber: json['vehicleNumber'],
      vType: json['vType'],
      odoImage: json['odoImage'],
      odoReading: json['odoReading'],
      startJourney: json['startJourney'],
      endJourney: json['endJourney'],
      longitude: json['longitude'],
      latitude: json['latitude']);

  toJson() => {
        'name': name,
        'empCode': empCode,
        'tName': tName,
        'leadName': leadName,
        'pickPoint': pickPoint,
        'driverName': driverName,
        'dNumber': dNumber,
        'vehicleNumber': vehicleNumber,
        'vType': vType,
        'odoImage': odoImage,
        'odoReading': odoReading,
        'startJourney': startJourney,
        'endJourney': endJourney,
        'longitude': longitude,
        'latitude': latitude
      };
}
