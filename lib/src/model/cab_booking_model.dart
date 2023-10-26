class CabBookingModel {
  String cabRDate;
  String teamName;
  String zone;
  String pc;
  String cabType;
  String personName;
  String empCode;
  String mobNum;
  String pickUpTime;
  String pickUpLocation;
  String destiantionLocation;
  String whomToMeet;
  String approvdeBy;
  String poTrip;
  double km;

  CabBookingModel(
      {required this.cabType,
      required this.cabRDate,
      required this.zone,
      required this.pc,
      required this.mobNum,
      required this.personName,
      required this.empCode,
      required this.teamName,
      required this.pickUpTime,
      required this.pickUpLocation,
      required this.destiantionLocation,
      required this.poTrip,
      required this.whomToMeet,
      required this.approvdeBy,
      required this.km});
  factory CabBookingModel.fromJson(Map<String, dynamic> json) =>
      CabBookingModel(
          cabType: json['cabType'],
          cabRDate: json["cabRDate"],
          zone: json['Zone'],
          pc: json['Pc'],
          whomToMeet: json['whomToMeet'],
          approvdeBy: json['approved_by'],
          mobNum: json['mobNum'],
          personName: json['personName'],
          teamName: json['teamName'],
          pickUpTime: json['pickUpTime'],
          pickUpLocation: json['pickUpLocation'],
          destiantionLocation: json['destiantionLocation'],
          poTrip: json['poTrip'],
          km: json['km'],
          empCode: json['emp_code']);

  Map<String, dynamic> toJson() => {
        'cabType': cabType,
        'cabRDate': cabRDate,
        'Zone': zone,
        'Pc': pc,
        "mobNum": mobNum,
        'personName': personName,
        'emp_code': empCode,
        'teamName': teamName,
        "pickUpTime": pickUpTime,
        'pickUpLocation': pickUpLocation,
        'destiantionLocation': destiantionLocation,
        'whomToMeet': whomToMeet,
        'approved_by': approvdeBy,
        'poTrip': poTrip,
        'km': km
      };
}
