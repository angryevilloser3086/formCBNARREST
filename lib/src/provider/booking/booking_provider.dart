import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  String cabRDate = '';
  TextEditingController teamName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController purposeOfTrip = TextEditingController();
  TextEditingController approxKM = TextEditingController();
  TextEditingController whomTOMeet = TextEditingController();
  String time = 'Select the Time';
  String sZones = '';
  String sPc = '';
  String sTypeReq = '';
  String sCabType = '';
  int hour = 0;
  int minute = 0;
  String apm = '';
  List<String> typeOFReq = [
    'Please Select the Type of Request',
    'Cab Request',
    'Accomodation',
    'Travel'
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

  List<String> typeOFCabReq = [
    'Please Select the Type of Request',
    'On-Call',
    'Extra Cab',
    'Monthly'
  ];
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateTime selectedDate = DateTime.now();
  void initDate() {
    cabRDate = formatter.format(selectedDate);
    processTime(selectedDate.hour, selectedDate.minute);
    // notifyListeners();
  }

  showDate(
    BuildContext context,
  ) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1999),
        lastDate: DateTime(2101));
    if (selected != null) {
      formatDate(selected);
      selectedDate = selected;
      print(cabRDate);
      notifyListeners();
    }
  }

  selectTimer(BuildContext context) async {
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
      processTimeSelected(context, timePicker);
      notifyListeners();
    }
  }

  void processTime(int h, int m) {
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
    time =
        "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, '0')} $apm";
    notifyListeners();
  }

  void processTimeSelected(BuildContext context, TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return;
    //pTimes(timeOfDay.hour, timeOfDay.minute);
    //print(timeOfDay.hour);
    // print(tImeFormat.hour! + tImeFormat.apm!);
    processTime(timeOfDay.hour, timeOfDay.minute);
  }

  void formatDate(DateTime date) {
    String fmtDate = formatter.format(date);
    cabRDate = fmtDate;
    notifyListeners();
  }

  void setReq(String value) {
    if (value == 'Please Select the Type of Request') {
      sTypeReq = '';
      sCabType = '';
    } else {
      sTypeReq = value;
      sCabType = '';
    }
    notifyListeners();
  }

  void setCabType(String value) {
    sCabType = value;
    notifyListeners();
  }
}
