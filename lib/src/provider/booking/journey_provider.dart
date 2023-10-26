import 'dart:developer';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';
import '../../model/emp_model.dart';
import '../../network/api_request.dart';
import '../../utils/app_utils.dart';
import '../../utils/loading_indicator.dart';
import '../../utils/shared_pref.dart';
import '../../view/bookingmodule/cab/map_screen.dart';
import '../images_upload/getimage_permission.dart';

class JourneyProvider extends ChangeNotifier {
  static const String googleApiKey = 'AIzaSyDlYLALZZw0yXpleOSxpGzGxLw-K86F9SY';
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController empCode = TextEditingController();
  TextEditingController teamName = TextEditingController();
  TextEditingController dName = TextEditingController();
  TextEditingController dNumber = TextEditingController();
  TextEditingController vNumber = TextEditingController();
  TextEditingController managerName = TextEditingController();
  TextEditingController startingPoint = TextEditingController();
  TextEditingController odoReading = TextEditingController();
  TextRecognition? textRecognition = TextRecognition();
  String destination = '';
  String odoMeter = '';
  ScrollController scrollController = ScrollController();
  String img = '';
  Employee? emp;
  String sVType = '';
  List<String> vType = [
    'Please Select Vehicle Type',
    'Sedan',
    'Hatchback',
    'SUV'
  ];
  ApiRequest apiRequest = ApiRequest();
  ImageSource? imageSource;
  SharedPref sharedPref = SharedPref();
  ImagePicker imagePicker = ImagePicker();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  initData() async {
    String mail = await sharedPref.read('mail');
    final value = await _db
        .collection('employees')
        .where('ofc_mail', isEqualTo: mail)
        .get();

    QuerySnapshot data = value;
    var js = data.docs[0].data() as Map<String, dynamic>;
    emp = Employee.fromJson(js);
  }

  getCamera(BuildContext context) async {
    // pics.clear();
    final firebaseStorage = FirebaseStorage.instance;
    imageSource = ImageSource.camera;
    GetImagePermission getPermission = GetImagePermission.camera();
    DateTime dt = DateTime.now();
    bool granted = await getPermission.getPermission(context);
    print(granted.toString());
    if (granted) {
      XFile? image =
          await imagePicker.pickImage(source: imageSource!, imageQuality: 50);
      if (image != null) {
        var file = File(image.path);
        DialogBuilder(context).showLoadingIndicator('uploading Image', '');
        var snapshot = await firebaseStorage
            .ref()
            .child('images/journey/')
            .child("${emp!.empID}_${dt.toIso8601String()}")
            .putFile(file)
            .whenComplete(
                () => Navigator.of(context, rootNavigator: true).pop());
        // .onComplete;
        final recognizedText =
            await textRecognition!.process(InputImage.fromFile(file));
        odoMeter = recognizedText!.text;
        odoReading = TextEditingController(text: recognizedText.text);
        log("${recognizedText.blocks}");
        log(recognizedText.text);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        img = (downloadUrl);
        // odoMeter =
        //     await FlutterTesseractOcr.extractText(img, language: 'eng', args: {
        //   "preserve_interword_spaces": "1",
        // });
        notifyListeners();
      }
    } else if (granted == false) {
      //Permission is not granted
      AppConstants.showSnackBar(
          context, "Please grant the permsissions for Camera");
      return;
    }
  }

  setVType(String value) {
    if (value == "Please Select Vehicle Type") {
      sVType = '';
    } else {
      sVType = value;
    }
    notifyListeners();
  }

  void updateLat(BuildContext context, String place) {
    DialogBuilder(context).showLoadingIndicator(
        "Please wait while we are loading....", "Loading");
    apiRequest.getLatLong(place).then((value) {
      Navigator.of(context, rootNavigator: true).pop();
      AppConstants.moveNextstl(
          context,
          MapScreen(
            dest: LatLng(value['latitude'], value['longitude']),
          ));
    }).catchError((err) {
      Navigator.of(context, rootNavigator: true).pop();
      print("err:$err");
      AppConstants.showSnackBar(context, "$err");
    });
    notifyListeners();
  }

  void startJourney() {
    //if()
  }
}
