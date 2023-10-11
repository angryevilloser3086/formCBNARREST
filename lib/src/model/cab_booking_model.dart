class CabBookingModel {
  Map<String, dynamic>? bookingEmp;
  String cabRDate;
  String teamName;
  String personName;
  String mobNum;
  String pickUpTime;
  String pickUpLocation;
  String destiantionLocation;
  String poTrip;
  double km;

  CabBookingModel(
      {required this.bookingEmp,
      required this.cabRDate,
      required this.mobNum,
      required this.personName,
      required this.teamName,
      required this.pickUpTime,
      required this.pickUpLocation,
      required this.destiantionLocation,
      required this.poTrip,
      required this.km});
  factory CabBookingModel.fromJson(Map<String, dynamic> json) =>
      CabBookingModel(
          bookingEmp: json["bookingEmp"],
          cabRDate: json["cabRDate"],
          mobNum: json['mobNum'],
          personName: json['personName'],
          teamName: json['teamName'],
          pickUpTime: json['pickUpTime'],
          pickUpLocation: json['pickUpLocation'],
          destiantionLocation: json['destiantionLocation'],
          poTrip: json['poTrip'],
          km: json['km']);
}
