import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form/src/view/home/homescreen.dart';
import '../../model/emp_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/shared_pref.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController userID = TextEditingController();
  TextEditingController passWord = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  SharedPref sharedPref = SharedPref();
  bool isLoader = false;
  Future<void> logInUser(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    isLoader = true;

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        await sharedPref.saveBool("isLoggedIn", true);
        await sharedPref.save("mail", email);
        AppConstants.showSnackBar(context, "Succesfully LoggedIn");
        AppConstants.moveNextClearAll(context, const HomeScreen());
        notifyListeners();
      }
    } catch (err) {
      isLoader = false;
      AppConstants.showSnackBar(context, "Login failed due to$err");
      notifyListeners();
    }
  }

  Future<void> createUserLogins(BuildContext context) async {
    try {
      _db.collection('employees').get().then((value) {
        QuerySnapshot data = value;
        List<Employee> emp = [];

        for (QueryDocumentSnapshot dd in data.docs) {
          print(jsonEncode(dd.data()));
          emp.add(Employee.fromJson(jsonDecode(jsonEncode(dd.data()))));
        }

        // int index = 0;
        for (var e in emp) {
          if (e.empID == null) {
          } else {
            String pass =
                "${e.empID?.substring(0, 3)}@${e.empID?.substring(3)}";
            _auth
                .fetchSignInMethodsForEmail(e.ofcMail.toString())
                .then((value) {
              print(value);
            }).catchError((err) {
              _auth
                  .createUserWithEmailAndPassword(
                      email: e.ofcMail!, password: pass)
                  .then((value) {
                print(value.credential!.asMap());
              }).catchError((err) {
                print(err);
              });
            });
          }
          // log("$pass ::::$index");
          // index++;
        }
        notifyListeners();
      });
    } catch (err) {
      AppConstants.showSnackBar(context, "Login failed due to$err");
      notifyListeners();
    }
  }

  bool isValidEmail(String value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }
}
