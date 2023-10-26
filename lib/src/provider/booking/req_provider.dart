import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/emp_model.dart';
import '../../model/raise_req.dart';
import '../../utils/app_utils.dart';
import '../../utils/notes_file.dart';
import '../../utils/shared_pref.dart';

class RequestProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<RaiseReqModel> reqModel = [];
  String notes = '';
  String level = '';
  bool checkReqs = true;
  String mail = '';
  String  dest='';
  bool enableSave = false;
  Employee? emp;
  SharedPref sharedPref = SharedPref();
  void getRequests(BuildContext context) async {
    checkReqs = true;
    mail = await sharedPref.read('mail');
    level = await sharedPref.read('level');
    _db
        .collection('employees')
        .where("ofc_mail", isEqualTo: mail)
        .get()
        .then((value) {
      emp = Employee.fromJson(value.docs.first.data());
      notifyListeners();
    }).catchError((err) {
      AppConstants.showSnackBar(context, "$err");
    });
    getData(context);
  }

  getData(BuildContext context) {
    _db.collection('admin_requests').get().then((value) {
      QuerySnapshot data = value;
      reqModel.clear();
      for (var d in data.docs) {
        RaiseReqModel req = RaiseReqModel(
            docID: d.id,
            id: d.get('id'),
            bookingEmp: d.get('bookingEmp'),
            typeOfReq: d.get('typeOfReq'),
            cabReq: d.get('cabReq'),
            accomodation: d.get('accomodation'),
            travel: d.get('travel'),
            status: d.get('status'),
            dateOfRaisedReq: d.get('dateOfRaisedReq'),
            reqLevel: d.get('request_level'),
            approvalDetails: d.get('approval_details'));
        if (int.parse(level) == 1) {
          if (mail == req.bookingEmp!['ofc_mail']) {
            reqModel.add(req);
          }
        } else if (int.parse(level) == 0) {
          if (req.typeOfReq.contains('Cab')) {
            if (req.cabReq!['emp_code'] == emp!.empID!.substring(0, 8)) {
              reqModel.add(req);
            }
          } else if (req.typeOfReq == 'Accomodation') {
            if (req.cabReq!['empCode'] == emp!.empID!.substring(0, 8)) {
              reqModel.add(req);
            }
          } else if (req.typeOfReq == 'Travel') {
            if (req.cabReq!['empCode'] == emp!.empID!.substring(0, 8)) {
              reqModel.add(req);
            }
          }
        } else {
          reqModel.add(req);
        }
      }
      checkReqs = false;
      notifyListeners();
    }).catchError((err) {
      checkReqs = false;
      //print(err);
      AppConstants.showSnackBar(context, "Failed get the requests due to $err");
      notifyListeners();
    });
  }

  void rejectReq(BuildContext context, RaiseReqModel req) async {
    DateTime dt = DateTime.now();
    ApprovalDetails approvalDe = ApprovalDetails(
        approvedBy: emp?.name ?? "",
        dateOfApproval: dt.toIso8601String(),
        approvalDetails: notes);
    RaiseReqModel r = RaiseReqModel(
        id: req.id,
        bookingEmp: req.bookingEmp,
        typeOfReq: req.typeOfReq,
        cabReq: req.cabReq,
        accomodation: req.accomodation,
        travel: req.travel,
        status: "Rejected",
        dateOfRaisedReq: req.dateOfRaisedReq,
        reqLevel: req.reqLevel,
        approvalDetails: approvalDe.toJson());
    enableSave = false;
    _db
        .collection('admin_requests')
        .doc(r.dateOfRaisedReq)
        .update(r.toJson())
        .then((value) {
      reqModel.clear();
      getData(context);
      AppConstants.showSnackBar(context, "Request rejected Successfully");
      notifyListeners();
    }).catchError((err) {
      AppConstants.showSnackBar(
          context, "Request rejection failed due to $err");
      notifyListeners();
    });
    await sharedPref.remove("Rejected");
  }

  onClickNotesBtn(BuildContext context) async {
    Size size = MediaQuery.of(context).size;

    var sheet = NotesAttachmentModalSheet(
      screenSize: size,
      title: 'Reason for Rejection',
    );
    await showModalBottomSheet(
      context: context,
      builder: (context) => sheet,
      isScrollControlled: true,
    );
    notes = await sharedPref.read('Rejected');
    print(notes);
    enableSave = true;
    notifyListeners();
  }

  onClickApproveBtn(BuildContext context) async {
    Size size = MediaQuery.of(context).size;

    var sheet = NotesAttachmentModalSheet(
      screenSize: size,
      title: 'Update Approval Details of the Request',
    );
    await showModalBottomSheet(
      context: context,
      builder: (context) => sheet,
      useSafeArea: true,
      isScrollControlled: true,
    );
    notes = await sharedPref.read('Approved');
    // print(notes);
    enableSave = true;
    notifyListeners();
  }

  approvetoMgmt(BuildContext context, RaiseReqModel req) {
    RaiseReqModel? r;
    DateTime dt = DateTime.now();

    if (req.reqLevel == '2') {
      ApprovalDetails approvalDe = ApprovalDetails(
          approvedBy: req.approvalDetails['approvedBy'] ?? "",
          dateOfApproval: req.approvalDetails['dateOfApproval'] ?? "",
          approvalDetails: notes);
      r = RaiseReqModel(
          id: req.id,
          bookingEmp: req.bookingEmp,
          typeOfReq: req.typeOfReq,
          cabReq: req.cabReq,
          accomodation: req.accomodation,
          travel: req.travel,
          status: enableSave ? "Approved" : "Approved by Admin",
          dateOfRaisedReq: req.dateOfRaisedReq,
          reqLevel: enableSave ? '2' : '3',
          approvalDetails: approvalDe.toJson());
    } else if (req.reqLevel == '3') {
      ApprovalDetails approvalDe = ApprovalDetails(
          approvedBy: emp?.name ?? "",
          dateOfApproval: dt.toIso8601String(),
          approvalDetails: notes);
      r = RaiseReqModel(
          id: req.id,
          bookingEmp: req.bookingEmp,
          typeOfReq: req.typeOfReq,
          cabReq: req.cabReq,
          accomodation: req.accomodation,
          travel: req.travel,
          status: "Approved",
          dateOfRaisedReq: req.dateOfRaisedReq,
          reqLevel: '2',
          approvalDetails: approvalDe.toJson());
    }
    _db
        .collection('admin_requests')
        .doc(r!.dateOfRaisedReq)
        .update(r.toJson())
        .then((value) {
      enableSave = false;
      reqModel.clear();
      getData(context);
      AppConstants.showSnackBar(context, "Request Approved Successfully");
      notifyListeners();
    }).catchError((err) {
      AppConstants.showSnackBar(context, "Request approval failed due to $err");
      notifyListeners();
    });
  }

  String changeDateFmt(String date) {
    if (date.isNotEmpty) {
      DateTime dt = DateTime.parse(date);
      DateFormat dateFormat = DateFormat.yMd().add_jm();
      return dateFormat.format(dt);
    } else {
      return "";
    }
  }

  updateDetails() {}
}
