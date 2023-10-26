class RaiseReqModel {
  //STCADM{typeofReq}0001
  String? docID;
  String id;
  String typeOfReq;
  Map<String, dynamic>? bookingEmp;
  Map<String, dynamic>? cabReq;
  Map<String, dynamic>? accomodation;
  Map<String, dynamic>? travel;
  String? status;
  String? dateOfRaisedReq;
  String reqLevel;
  Map<String, dynamic> approvalDetails;

  RaiseReqModel(
      {required this.id,
      this.docID,
      required this.bookingEmp,
      required this.typeOfReq,
      required this.cabReq,
      required this.accomodation,
      required this.travel,
      required this.status,
      required this.dateOfRaisedReq,
      required this.reqLevel,
      required this.approvalDetails});
  factory RaiseReqModel.fromJson(Map<String, dynamic> json) => RaiseReqModel(
      bookingEmp: json['bookingEmp'],
      typeOfReq: json['typeOfReq'],
      cabReq: json['cabReq'],
      accomodation: json['accomodation'],
      travel: json['travel'],
      status: json['status'],
      dateOfRaisedReq: json['dateOfRaisedReq'],
      id: json['id'],
      reqLevel: json['request_level'],
      approvalDetails: json['approval_details']);
  Map<String, dynamic> toJson() => {
        'id': id,
        'bookingEmp': bookingEmp,
        'typeOfReq': typeOfReq,
        'cabReq': cabReq,
        'accomodation': accomodation,
        'travel': travel,
        'status': status,
        'dateOfRaisedReq': dateOfRaisedReq,
        'request_level': reqLevel,
        'approval_details': approvalDetails
      };
}

class ApprovalDetails {
  String? approvedBy;
  String? dateOfApproval;
  String? approvalDetails;
  ApprovalDetails(
      {required this.approvedBy,
      required this.dateOfApproval,
      required this.approvalDetails});
  factory ApprovalDetails.fromJson(Map<String, dynamic> json) =>
      ApprovalDetails(
          approvedBy: json['approvedBy'],
          dateOfApproval: json['dateOfApproval'],
          approvalDetails: json['approvalDetails']);
  Map<String, dynamic> toJson() => {
        'approvedBy': approvedBy,
        'dateOfApproval': dateOfApproval,
        'approvalDetails': approvalDetails
      };
}
