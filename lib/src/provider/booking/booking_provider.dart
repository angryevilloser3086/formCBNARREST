import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/accomodation_model.dart';
import '../../model/cab_booking_model.dart';
import '../../model/emp_model.dart';
import '../../model/raise_req.dart';
import '../../model/travel.dart';
import '../../utils/app_utils.dart';
import '../../utils/loading_indicator.dart';
import '../../utils/shared_pref.dart';
import '../../view/bookingmodule/booking form/booking_form.dart';

class BookingProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  TextEditingController name = TextEditingController();
  TextEditingController droppingPoint = TextEditingController();
  TextEditingController locFrom = TextEditingController();
  TextEditingController empCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController poVisit = TextEditingController();
  String cabRDate = '';
  SharedPref sharedPref = SharedPref();
  String checkoutDate = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController teamName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController purposeOfTrip = TextEditingController();
  TextEditingController approxKM = TextEditingController();
  TextEditingController whomTOMeet = TextEditingController();
  TextEditingController approvedBY = TextEditingController();
  String time = 'Select the Time';
  String checkOutTime = '';
  String sZones = '';
  String sMoT = '';
  String sPc = '';
  String movementTyep = '';
  String sTypeReq = '';
  String sCabType = '';
  int hour = 0;
  int minute = 0;
  String apm = '';
  bool setSubmit = false;
  List<String> typeOFReq = [
    'Please Select the Type of Request',
    'Cab Request',
    'Accomodation',
    'Travel'
  ];

  List<String> modeOfTravel = [
    'Please Select Model of Travel',
    'Bus',
    'Train',
    'Flight'
  ];
  List<String> typeMove = [
    "Please Select type of movement",
    "Permenant",
    "Temporary"
  ];
  List<String> zones = [
    'Please select your Zone',
    'Zone 1',
    'Zone 2',
    'Zone 3',
    'Zone 4',
    'Zone 5'
  ];

  List<String> zone1 = [
    'select your PC',
    'Srikakulam',
    'Vizianagaram',
    'Visakhapatnam',
    'Anakapalli',
    'Araku',
  ];

  List<String> zone2 = [
    'Please select your PC',
    'Rajahmundry',
    'Kakinada',
    'Narsapuram',
    'Amalapuram',
    'Eluru',
  ];
  List<String> zone3 = [
    'Please select your PC',
    'Guntur',
    'Vijayawada',
    'Machilipatnam',
    'Narasaraopet',
    'Bapatla',
  ];
  List<String> zone4 = [
    'Please select your PC',
    'Ongole',
    'Nellore',
    'Tirupati',
    'Nellore',
    'Rajampet',
    'Chittoor',
  ];
  List<String> zone5 = [
    'Please select your PC',
    'Kadapa',
    'Nandyal',
    'Kurnool',
    'Anantapur',
    'Hindupur',
  ];

  List<String> sendZonePc(String value) {
    if (value.isNotEmpty && value != 'Please select your Zone') {
      if (value == 'Zone 1') {
        return zone1;
      } else if (value == 'Zone 2') {
        return zone2;
      } else if (value == 'Zone 3') {
        return zone3;
      } else if (value == 'Zone 4') {
        return zone4;
      } else if (value == 'Zone 5') {
        return zone5;
      } else {
        return ['Please select your Zone'];
      }
    } else {
      return ['Please select your Zone'];
    }
  }

  setZone(String value) {
    if (value == "select your Zone") {
      sZones = '';
      sPc = '';
      return "Please select your Zone";
    } else {
      sZones = value;
      sPc = '';
    }
    notifyListeners();
  }

  setPc(String value) {
    sPc = value;
    notifyListeners();
  }

  setMT(String value) {
    if (value == 'Please Select type of movement') {
      movementTyep = '';
    } else {
      movementTyep = value;
    }
    notifyListeners();
  }

  setMOT(String value) {
    if (value == 'Please Select Model of Travel') {
      sMoT = '';
    } else {
      sMoT = value;
    }
    notifyListeners();
  }

  List<String> typeOFCabReq = [
    'Please Select the Type of Request',
    'On-Call',
    'Extra Cab',
    'Monthly'
  ];
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateTime selectedDate = DateTime.now();
  void initDate(bool checkout) {
    if (checkout) {
      checkoutDate = formatter.format(selectedDate);
      //print(checkoutDate);
    } else {
      cabRDate = formatter.format(selectedDate);
    }
    processTime(selectedDate.hour, selectedDate.minute, checkout);
    // notifyListeners();
  }

  showDate(BuildContext context, bool checkoutD) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1999),
        lastDate: DateTime(2101));
    if (selected != null) {
      formatDate(selected, checkoutD);
      selectedDate = selected;
      //print(cabRDate);
      notifyListeners();
    }
  }

  selectTimer(BuildContext context, bool checkOut) async {
    DateTime time = DateTime.now();
    TimeOfDay? timePicker = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: time.hour, minute: time.minute),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (timePicker.toString().isNotEmpty) {
      processTimeSelected(context, timePicker, checkOut);
      notifyListeners();
    }
  }

  void processTime(int h, int m, bool checkout) {
    int _hour = h;
    int _min = m;
    String _apm = "AM";

    if (h > 12) {
      _hour = h - 12;
    }
    if (h >= 12) {
      _apm = "PM";
    }

    hour = _hour;
    minute = _min;
    apm = _apm;
    //print(hour);
    //print(checkout);
    if (!checkout) {
      time =
          "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, '0')} $apm";
    } else {
      checkOutTime =
          "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, '0')} $apm";
    }
    //notifyListeners();
  }

  void processTimeSelected(
      BuildContext context, TimeOfDay? timeOfDay, bool checkOut) {
    if (timeOfDay == null) return;
    processTime(timeOfDay.hour, timeOfDay.minute, checkOut);
  }

  void formatDate(DateTime date, bool checkoutD) {
    String fmtDate = formatter.format(date);
    if (!checkoutD) {
      cabRDate = fmtDate;
    } else {
      checkoutDate = fmtDate;
    }
    notifyListeners();
  }

  void setReq(String value) {
    if (value == 'Please Select the Type of Request') {
      sTypeReq = '';
      sCabType = '';
      setSubmit = false;
      clearEverything();
    } else {
      sTypeReq = value;
      if (value == 'Accomodation' || value == 'Travel') {
        setSubmit = true;
      } else {
        setSubmit = false;
      }

      clearEverything();
      sCabType = '';
    }
    notifyListeners();
  }

  clearEverything() {
    name.clear();
    sZones = '';
    sPc = '';
    pickUpLocation.clear();
    teamName.clear();
    number.clear();
    destination.clear();
    purposeOfTrip.clear();
    poVisit.clear();
    state.clear();
    city.clear();
    locFrom.clear();
    droppingPoint.clear();
    approxKM.clear();
    age.clear();
    whomTOMeet.clear();
    empCode.clear();
    sZones = '';
    movementTyep = '';
    sMoT = '';
    approvedBY.clear();

    notifyListeners();
  }

  void setCabType(String value) {
    if (value == 'Please Select the Type of Request') {
      sCabType = '';
      setSubmit = false;
      clearEverything();
    } else {
      setSubmit = true;
      print(value);
      sCabType = value;
      clearEverything();
    }
    notifyListeners();
  }

  void setSubmitBtn(BuildContext context) async {
    DateTime dt = DateTime.now();
    var len = await _db.collection('admin_requests').count().get();
    int length = len.count;
    String lss = '';
    if (length < 10) {
      lss = (length + 1).toString().padLeft(5, '0');
    } else if (length < 100) {
      lss = (length + 1).toString().padLeft(4, '0');
    } else if (length < 1000) {
      lss = (length + 1).toString().padLeft(3, '0');
    } else if (length < 10000) {
      lss = (length + 1).toString().padLeft(2, '0');
    }
    //print(length);
    String id = 'STCADM${sTypeReq.substring(0, 1)}$lss';
    //print(id);
    Employee emp;
    String mail = await sharedPref.read('mail');
    final value = await _db
        .collection('employees')
        .where('ofc_mail', isEqualTo: mail)
        .get();

    QuerySnapshot data = value;
    var js = data.docs[0].data() as Map<String, dynamic>;
    emp = Employee.fromJson(js);
    if (sTypeReq == 'Cab Request') {
      if (formKey.currentState!.validate()) {
        if (sCabType.isNotEmpty && sCabType == "Extra Cab") {
          if (sZones.isNotEmpty && sPc.isNotEmpty && time.isNotEmpty) {
            DialogBuilder(context).showLoadingIndicator(
                'Please wait while we are raising your request..', '');

            CabBookingModel cbm = CabBookingModel(
                cabType: sCabType,
                cabRDate: cabRDate,
                zone: sZones,
                pc: sPc,
                mobNum: number.text,
                personName: name.text,
                teamName: teamName.text,
                pickUpTime: time,
                pickUpLocation: pickUpLocation.text,
                destiantionLocation: destination.text,
                poTrip: purposeOfTrip.text,
                whomToMeet: whomTOMeet.text,
                approvdeBy: approvedBY.text,
                km: 0,
                empCode: empCode.text);
            RaiseReqModel reqModel = RaiseReqModel(
                id: id,
                bookingEmp: emp.toJson(),
                typeOfReq: sTypeReq,
                cabReq: cbm.toJson(),
                accomodation: {},
                travel: {},
                status: "In Process",
                dateOfRaisedReq: dt.toIso8601String(),
                reqLevel: '2',
                approvalDetails: {});
            updateDetails(context, reqModel.toJson(), dt.toIso8601String());
          }
        } else if (sCabType.isNotEmpty &&
            (sCabType == "On-Call" || sCabType == "Monthly")) {
          if (cabRDate.isNotEmpty && time.isNotEmpty) {
            DialogBuilder(context).showLoadingIndicator(
                'Please wait while we are raising your request..', '');

            CabBookingModel cbm = CabBookingModel(
                cabType: sCabType,
                cabRDate: cabRDate,
                zone: sZones,
                pc: sPc,
                mobNum: number.text,
                personName: name.text,
                teamName: teamName.text,
                pickUpTime: time,
                pickUpLocation: pickUpLocation.text,
                destiantionLocation: destination.text,
                poTrip: purposeOfTrip.text,
                whomToMeet: whomTOMeet.text,
                approvdeBy: '',
                km: double.parse(approxKM.text),
                empCode: empCode.text);
            RaiseReqModel reqModel = RaiseReqModel(
                id: id,
                bookingEmp: emp.toJson(),
                typeOfReq: sTypeReq,
                cabReq: cbm.toJson(),
                accomodation: {},
                travel: {},
                status: "In Process",
                dateOfRaisedReq: dt.toIso8601String(),
                reqLevel: '2',
                approvalDetails: {});
            updateDetails(context, reqModel.toJson(), dt.toIso8601String());
          }
        }
      }
    } else if (sTypeReq == 'Accomodation') {
      if (formKey.currentState!.validate()) {
        if (cabRDate.isNotEmpty &&
            time.isNotEmpty &&
            checkOutTime.isNotEmpty &&
            checkoutDate.isNotEmpty &&
            movementTyep.isNotEmpty) {
          DialogBuilder(context).showLoadingIndicator(
              'Please wait while we are raising your request..', '');
          AccomodationModel acm = AccomodationModel(
              personName: name.text,
              mobNum: number.text,
              eMpCode: empCode.text,
              city: city.text,
              state: state.text,
              purposeOfVisit: poVisit.text,
              checkInDt: cabRDate,
              checkInTm: time,
              checkOutDt: checkoutDate,
              checkOutTm: checkOutTime,
              movementType: movementTyep,
              approvedBy: approvedBY.text);
          RaiseReqModel reqModel = RaiseReqModel(
              id: id,
              bookingEmp: emp.toJson(),
              typeOfReq: sTypeReq,
              cabReq: {},
              accomodation: acm.toJson(),
              travel: {},
              status: "In Process",
              dateOfRaisedReq: dt.toIso8601String(),
              reqLevel: '2',
              approvalDetails: {});
          updateDetails(context, reqModel.toJson(), dt.toIso8601String());
        } else {
          AppConstants.showSnackBar(context, "Please Enter all the details");
        }
      } else {
        AppConstants.showSnackBar(context, "Please Enter all the details");
      }
    } else if (sTypeReq == 'Travel') {
      if (formKey.currentState!.validate()) {
        if (cabRDate.isNotEmpty && sMoT.isNotEmpty && time.isNotEmpty) {
          DialogBuilder(context).showLoadingIndicator(
              'Please wait while we are raising your request..', '');
          TravelModel travelModel = TravelModel(
              personName: name.text,
              mobNum: number.text,
              age: age.text,
              empCode: empCode.text,
              travellingDt: cabRDate,
              modeOfTravel: sMoT,
              locFrom: locFrom.text,
              destination: destination.text,
              pickUpPoint: pickUpLocation.text,
              droppingPoint: droppingPoint.text,
              preferredTiming: time,
              approvedBy: approvedBY.text);

          RaiseReqModel reqModel = RaiseReqModel(
              id: id,
              bookingEmp: emp.toJson(),
              typeOfReq: sTypeReq,
              cabReq: {},
              accomodation: {},
              travel: travelModel.toJson(),
              status: "In Process",
              dateOfRaisedReq: dt.toIso8601String(),
              reqLevel: '2',
              approvalDetails: {});
          updateDetails(context, reqModel.toJson(), dt.toIso8601String());
        } else {
          AppConstants.showSnackBar(context, "Please Enter all the Details");
        }
      }
    }
  }

  updateDetails(BuildContext context, Map<String, dynamic> json, String dt) {
    _db.collection("admin_requests").doc(dt).set(json).then((value) {
      Navigator.of(context, rootNavigator: true).pop();
      AppConstants.showSnackBar(context, "Successfully Updated");
      AppConstants.moveNextClearAll(context, const BookingForm());
    }).catchError((err) {
      Navigator.of(context, rootNavigator: true).pop();
      AppConstants.showSnackBar(context, "$err");
    });
  }
}
