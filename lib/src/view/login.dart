import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                      "సీబీఎన్ అరెస్టుపై ప్రజాభిప్రాయం/Public Opinion on CBN Arrest",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 30,
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
                )
              ],
            ),
          ),
        ),
      )),
    );
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
