class TravelModel {
  String personName;
  String mobNum;
  String empCode;
  String age;
  String travellingDt;
  String modeOfTravel;
  String locFrom;
  String destination;
  String pickUpPoint;
  String droppingPoint;
  String preferredTiming;
  String approvedBy;
  TravelModel(
      {required this.personName,
      required this.mobNum,
      required this.age,
      required this.empCode,
      required this.travellingDt,
      required this.modeOfTravel,
      required this.locFrom,
      required this.destination,
      required this.pickUpPoint,
      required this.droppingPoint,
      required this.preferredTiming,
      required this.approvedBy});

  factory TravelModel.fromJson(Map<String, dynamic> json) => TravelModel(
      personName: json['personName'],
      mobNum: json['mobNum'],
      age: json['age'],
      empCode: json['empCode'],
      travellingDt: json['travellingDt'],
      modeOfTravel: json['modeOfTravel'],
      locFrom: json['location_from'],
      destination: json['destination'],
      pickUpPoint: json['pickUpPoint'],
      droppingPoint: json['droppingPoint'],
      preferredTiming: json['preferredTiming'],
      approvedBy: json['approvedBy']);
  Map<String, dynamic> toJson() => {
        'personName': personName,
        'mobNum': mobNum,
        'age': age,
        'empCode': empCode,
        'travellingDt': travellingDt,
        'modeOfTravel': modeOfTravel,
        'location_from': locFrom,
        'destination': destination,
        'pickUpPoint': pickUpPoint,
        'droppingPoint': droppingPoint,
        'preferredTiming': preferredTiming,
        'approvedBy': approvedBy
      };
}
