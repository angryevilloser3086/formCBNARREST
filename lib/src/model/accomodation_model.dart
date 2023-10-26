class AccomodationModel {
  String personName;
  String mobNum;
  String eMpCode;
  String city;
  String state;
  String purposeOfVisit;
  String checkInDt;
  String checkInTm;
  String checkOutDt;
  String checkOutTm;
  String movementType;
  String approvedBy;

  AccomodationModel(
      {required this.personName,
      required this.mobNum,
      required this.eMpCode,
      required this.city,
      required this.state,
      required this.purposeOfVisit,
      required this.checkInDt,
      required this.checkInTm,
      required this.checkOutDt,
      required this.checkOutTm,
      required this.movementType,
      required this.approvedBy});
  factory AccomodationModel.fromJson(Map<String, dynamic> json) =>
      AccomodationModel(
          personName: json['personName'] ?? "",
          mobNum: json['mobNum'] ?? "",
          eMpCode: json['empCode'] ?? "",
          city: json['city'] ?? "",
          state: json['state'] ?? "",
          purposeOfVisit: json['purposeOfVisit'] ?? "",
          checkInDt: json['checkInDt'] ?? "",
          checkInTm: json['checkInTm'] ?? "",
          checkOutDt: json['checkOutDt'] ?? "",
          checkOutTm: json['checkOutTm'] ?? "",
          movementType: json['movementType'] ?? "",
          approvedBy: json['approvedBy'] ?? "");

  Map<String, dynamic> toJson() => {
        'personName': personName,
        'empCode': eMpCode,
        "mobNum": mobNum,
        'city': city,
        'state': state,
        'purposeOfVisit': purposeOfVisit,
        'checkInDt': checkInDt,
        'checkInTm': checkInTm,
        'checkOutDt': checkOutDt,
        'checkOutTm': checkOutTm,
        'movementType': movementType,
        'approvedBy': approvedBy
      };
}
