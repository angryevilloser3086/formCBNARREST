import 'package:flutter/material.dart';

import '../../utils/app_utils.dart';
import '../../utils/shared_pref.dart';
import '../../view/login/login.dart';

class HomeProvider extends ChangeNotifier {
  SharedPref sharedPref = SharedPref();
  String vName = '';
  String vMail = '';
  init() async {
    vName = await sharedPref.read("name");
    vMail = await sharedPref.read("mail");

    notifyListeners();
    //print(vNam + vName.text);
  }

  clearAll(BuildContext context) async {
    await sharedPref.clear();
    AppConstants.moveNextClearAll(context, const LoginScreen());
    notifyListeners();
  }
}
