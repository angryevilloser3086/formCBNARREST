import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/app_utils.dart';
import '../utils/shared_pref.dart';
import 'form.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showLoader = false;
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    showLoader = true;
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => checkEmp());
  }

  void checkEmp() {
    //var body = FirebaseAuth.instance.currentUser;
    sharedPref.read('mail').then((value) {
      if (value.toString().isNotEmpty) {
        setState(() {
          showLoader = false;
          AppConstants.moveNextClearAll(context, const FormScreen());
        });
      } else {
        setState(() {
          showLoader = false;
          AppConstants.moveNextstl(context, const LoginScreen());
        });
      }
    }).catchError((err){
      setState(() {
          showLoader = false;
          AppConstants.moveNextstl(context, const LoginScreen());
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appYellowBG,
      body: SafeArea(
          child: Column(
        children: [
          AppConstants.h_40,
          // Padding(
          //   padding: AppConstants.all_10,
          //   child: Image.asset("assets/images/ic_new_logo.png"),
          // ),
          AppConstants.h_20,
          if (showLoader)
            const Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                color: AppConstants.appredColor,
              ),
            )
        ],
      )),
    );
  }
}
