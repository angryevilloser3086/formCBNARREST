import 'package:flutter/material.dart';
import 'package:flutter_form/src/view/home/homescreen.dart';

import '../../utils/app_utils.dart';
import '../../utils/shared_pref.dart';
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
          AppConstants.moveNextClearAll(context, const HomeScreen());
        });
      } else {
        setState(() {
          showLoader = false;
          AppConstants.moveNextstl(context, const LoginScreen());
        });
      }
    }).catchError((err) {
      setState(() {
        showLoader = false;
        AppConstants.moveNextstl(context, const LoginScreen());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appSTCColor,
      body: SafeArea(
          child: Column(
        children: [
          AppConstants.h_40,
          const Spacer(
            flex: 2,
          ),
          Padding(
            padding: AppConstants.all_10,
            child: Image.asset("assets/images/STC_logo.png"),
          ),
          const Spacer(
            flex: 3,
          ),
          AppConstants.h_20,
          if (showLoader)
            const Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          AppConstants.h_20,
        ],
      )),
    );
  }
}
