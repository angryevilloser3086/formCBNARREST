import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../firebase_options.dart';
import '../network/api_request.dart';
import '/src/utils/shared_pref.dart';
import '/src/view/form.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _controller;
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appYellowBG,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: AppConstants.all_10,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      "సీబీఎన్ అరెస్టుపై ప్రజాభిప్రాయం\nPublic Opinion on CBN Arrest",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900)),
                ),
                p3q1(context,
                    "దయచేసి పేరును నమోదు చేయండి/Please Enter the Name"),
                p3q2(context,
                    "దయచేసి మీ మెయిల్‌ని నమోదు చేయండి/Please Enter your Mail"),
                InkWell(
                  onTap: () {
                    saveDetails();
                  },
                  child: btn(context, "Next"),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      downloadData();
                    });
                  },
                  child: btnDownload(),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  btnDownload() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 50,
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: const Center(child: Text("Download")),
      ),
    );
  }

  downloadData() async {
    ApiRequest apiRequest = ApiRequest();
    final databaseReference = FirebaseDatabase.instanceFor(
        app: await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        databaseURL: apiRequest.dbUrl);
    List<Map<String, dynamic>> data = [];
    databaseReference.ref("/cbn_arrest").get().then((value) {
      //   print(value.children.toList());
      setState(() {
        for (var element in value.children) {
          //print(element.children.first.value);
          data.add({
            "vname": element.child("vname").value,
            "vMail": element.child("vMail").value,
            "date": element.child("date").value,
            "Name of the responder":
                element.child("Name of the responder").value,
            "Do you know about the arrest of Chandra Babu Naidu?": element
                .child("Do you know about the arrest of Chandra Babu Naidu?")
                .value,
            "What do you think about the arrest of Chandra Babu Naidu?": element
                .child(
                    "What do you think about the arrest of Chandra Babu Naidu?")
                .value,
            "Why do you think he was arrested?":
                element.child("Why do you think he was arrested?").value,
            "How did the Police behave during his arrest?": element
                .child("How did the Police behave during his arrest?")
                .value,
            "What do you think about the alliance between JSP and TDP?": element
                .child(
                    "What do you think about the alliance between JSP and TDP?")
                .value,
            "If BJP join with TDP-JSP alliance, will the alliance be stronger?":
                element
                    .child(
                        "If BJP join with TDP-JSP alliance, will the alliance be stronger?")
                    .value,
            "Phone Number of the Responder":
                element.child("Phone Number of the Responder").value,
            "Which Constituency do you belong to?":
                element.child("Which Constituency do you belong to?").value,
            "Longitude": element.child("Longitude").value,
            "Latitude": element.child("Latitude").value,
          });
          print({
            "vname": element.child("vname").value,
            "vMail": element.child("vMail").value,
            "date": element.child("date").value,
            "Name of the responder":
                element.child("Name of the responder").value,
            "Do you know about the arrest of Chandra Babu Naidu?": element
                .child("Do you know about the arrest of Chandra Babu Naidu?")
                .value,
            "What do you think about the arrest of Chandra Babu Naidu?": element
                .child(
                    "What do you think about the arrest of Chandra Babu Naidu?")
                .value,
            "Why do you think he was arrested?":
                element.child("Why do you think he was arrested?").value,
            "How did the Police behave during his arrest?": element
                .child("How did the Police behave during his arrest?")
                .value,
            "What do you think about the alliance between JSP and TDP?": element
                .child(
                    "What do you think about the alliance between JSP and TDP?")
                .value,
            "If BJP join with TDP-JSP alliance, will the alliance be stronger?":
                element
                    .child(
                        "If BJP join with TDP-JSP alliance, will the alliance be stronger?")
                    .value,
            "Phone Number of the Responder":
                element.child("Phone Number of the Responder").value,
            "Which Constituency do you belong to?":
                element.child("Which Constituency do you belong to?").value,
            "Longitude": element.child("Longitude").value,
            "Latitude": element.child("Latitude").value,
          });
        }

        convertJSONToExcel(data);
      });
    });
  }

  void convertJSONToExcel(List<Map<String, dynamic>> jsonData) {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Write headers (optional) - Assuming jsonData is a list of Maps with identical keys
    // var headers = jsonData[0].toList();
    List<String> headers = [
      "Timestamp",
      "Email address",
      "Name of the responder",
      "Do you know about the arrest of Chandra Babu Naidu?",
      "What do you think about the arrest of Chandra Babu Naidu?",
      "Why do you think he was arrested?",
      "How did the Police behave during his arrest?",
      "Phone Number of the Responder",
      "Which Constituency do you belong to?",
      "What do you think about the alliance between JSP and TDP?",
      "If BJP join with TDP-JSP alliance, will the alliance be stronger?",
      "Latitude",
      "Longitude",
    ];
    for (var i = 0; i < headers.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: i))
          .value = headers[i];
    }
    print(jsonData.length);
    // Write data
    for (var i = 0; i < jsonData.length; i++) {
      Map<String, dynamic> row = jsonData[i];
      //var values = row;Timestamp	Email address	Name of the responder	1. Do you know about the arrest of Chandra Babu Naidu?	2. What do you think about the arrest of Chandra Babu Naidu?	4. How did the Police behave during his arrest?	3. Why do you think Chandra Babu Naidu was arrested?	Phone Number of the Responder	Which Constituency do you belong to?	5. What do you think about the alliance between JSP and TDP?	6. If BJP join with TDP- JSP alliance, will the alliance be stronger?

      List<String?> val = [];
      val.add(row["date"] ?? "");
      //val.add(row["vname"] ?? "");
      val.add(row["vMail"] ?? "");
      val.add(row["Name of the responder"] ?? "");
      val.add(row["Do you know about the arrest of Chandra Babu Naidu?"]
              .toString()
              .split("/")
              .last);
      val.add(row["What do you think about the arrest of Chandra Babu Naidu?"]
              .toString()
              .split("/")
              .last);
      val.add(
          row["Why do you think he was arrested?"].toString().split("/").last ??
              "");
      val.add(row["How did the Police behave during his arrest?"]
          .toString()
          .split("/")
          .last);
      val.add(row["Phone Number of the Responder"] ?? "");
      val.add(row["Which Constituency do you belong to?"]
              .toString()
              .split("/")
              .first ??
          "");
      val.add(row["What do you think about the alliance between JSP and TDP?"]
              .toString()
              .split("/")
              .last ??
          "");
      val.add(
          row["If BJP join with TDP-JSP alliance, will the alliance be stronger?"]
                  .toString()
                  .split("/")
                  .last ??
              "");

      val.add(row["Latitude"].toString());
      val.add(row["Longitude"].toString());
      log("${val.toList()}");

      for (var j = 0; j < val.length; j++) {
        log("calledhere");
        setState(() {
          sheet
              .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: j))
              .value = val[j];
        });
      }
    }
    DateTime dt = DateTime.now();
    setState(() {
      var fileBytes = excel.save(fileName: 'details$dt.xlsx');
      log("${fileBytes!.toList()}");
    });
  }

  saveDetails() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        sharedPref.save("name", name.text);
        sharedPref.save("mail", number.text);
      });
      AppConstants.moveNextClearAll(context, const FormScreen());
    } else {
      AppConstants.showSnackBar(context, "Please enter all details");
    }
  }

  btn(BuildContext context, String title) {
    return Center(
      child: Container(
        width: 100,
        height: 50,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  p3q1(BuildContext context, String title) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(title,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Answer';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                  //addNewPeople.formKey.currentState!.validate();
                },
                textAlign: TextAlign.justify,
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                decoration: InputDecoration(
                    // contentPadding: AppConstants.all_5,
                    fillColor: Colors.white,
                    filled: true,
                    counterStyle: Theme.of(context).textTheme.bodySmall,
                    counterText: "",
                    hintText: "Enter Answer",
                    errorStyle: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                    hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8)),
                keyboardType: TextInputType.multiline,
                maxLength: 40,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                //controller: addNewPeople.fnameController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  p3q2(BuildContext context, String title) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(title,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  } else if (!value.endsWith('@showtimeconsulting.in')) {
                    return 'Invalid email address';
                  }
                  // else if (!value.endsWith('@SHOWTIMECONSULTING.IN')) {
                  //   return 'Invalid email address';
                  // }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                  //addNewPeople.formKey.currentState!.validate();
                },
                textAlign: TextAlign.justify,
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                decoration: InputDecoration(
                    // contentPadding: AppConstants.all_5,
                    fillColor: Colors.white,
                    filled: true,
                    counterStyle: Theme.of(context).textTheme.bodySmall,
                    counterText: "",
                    hintText: "Enter Answer",
                    errorStyle: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                    hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8)),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                //controller: addNewPeople.fnameController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
