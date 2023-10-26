import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/app_utils.dart';
import '../../utils/shared_pref.dart';
import '../../view/login/login.dart';

class HomeProvider extends ChangeNotifier {
  SharedPref sharedPref = SharedPref();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String vName = '';
  String vMail = '';
  String level = '';
  init() async {
    // vName = await sharedPref.read("name");
    vMail = await sharedPref.read("mail");
    final value = await _db
        .collection('employees')
        .where('ofc_mail', isEqualTo: vMail)
        .get();
    QuerySnapshot data = value;
    var js = data.docs[0].data() as Map<String, dynamic>;
    vName = js['name'];
    level = js['level'];
    await sharedPref.save("level", js['level']);
    notifyListeners();
    //print(vNam + vName.text);
  }

  clearAll(BuildContext context) async {
    _auth.signOut().then((value) {
      sharedPref.clear();
      AppConstants.moveNextClearAll(context, const LoginScreen());
    }).catchError((err) {
      AppConstants.showSnackBar(context, "$err");
    });

    notifyListeners();
  }
}
