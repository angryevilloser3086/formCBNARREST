import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../view/branding/branding_home.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../firebase_options.dart';
import '../../model/branding_model.dart';
import '../../network/api_request.dart';
import '../../utils/app_utils.dart';
import '../../utils/loading_indicator.dart';
import '../../utils/shared_pref.dart';
import '../images_upload/getimage_permission.dart';

class BrandProvider extends ChangeNotifier {
  TextEditingController vName = TextEditingController();
  TextEditingController vMail = TextEditingController();
  TextEditingController noPosters = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController len = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController hName = TextEditingController();
  TextEditingController hNum = TextEditingController();
  TextEditingController pName = TextEditingController();
  TextEditingController pNum = TextEditingController();
  ApiRequest apiRequest = ApiRequest();
  ImageSource? imageSource;
  ImagePicker imagePicker = ImagePicker();
  ScrollController scrollController = ScrollController();
  String sZones = '';
  String sPc = '';
  String sAc = '';
  String lat = '';
  String long = '';
  String locate = '';
  String siteType = '';
  String areaType = '';
  List<String> pics = [];
  SharedPref sharedPref = SharedPref();
  Location location = Location();
  bool serviceEnabled = false;
  bool enableBTN = true;
  int index = 0;
  String typeOfBranding = '';

  init() async {
    String vNam = await sharedPref.read("name");
    String mail = await sharedPref.read("mail");
    vName = TextEditingController(text: vNam);
    vMail = TextEditingController(text: mail);
    notifyListeners();
    //print(vNam + vName.text);
  }

  List<String> brandingTypes = [
    "Please select the type of Branding",
    "Hoarding",
    "Wall Painting",
    "Posters"
  ];

  List<String> siteTypes = [
    "Please Select the Site Type",
    "Public Property",
    "Private Property",
  ];

  List<String> areaTypes = [
    "Please Select the Area Type",
    "National Highway",
    "State Highway",
    "Locality"
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

  List<String> sendPcAc(String value) {
    if (value.isNotEmpty && value != 'Please select your PC') {
      if (value == 'Srikakulam') {
        return srikakulam;
      } else if (value == 'Vizianagaram') {
        return vizianagaram;
      } else if (value == 'Visakhapatnam') {
        return vizag;
      } else if (value == 'Anakapalli') {
        return anakapalli;
      } else if (value == 'Araku') {
        return araku;
      } else if (value == 'Rajahmundry') {
        return rjy;
      } else if (value == 'Kakinada') {
        return kkd;
      } else if (value == 'Narsapuram') {
        return narsapur;
      } else if (value == 'Amalapuram') {
        return amp;
      } else if (value == 'Eluru') {
        return eluru;
      } else if (value == 'Guntur') {
        return guntur;
      } else if (value == 'Vijayawada') {
        return vjy;
      } else if (value == 'Machilipatnam') {
        return machilipatnam;
      } else if (value == 'Narasaraopet') {
        return narsaroapet;
      } else if (value == 'Bapatla') {
        return baptla;
      } else if (value == 'Ongole') {
        return ongole;
      } else if (value == 'Tirupati') {
        return tirupati;
      } else if (value == 'Nellore') {
        return nellore;
      } else if (value == 'Rajampet') {
        return rajampet;
      } else if (value == 'Chittoor') {
        return chittor;
      } else if (value == 'Kadapa') {
        return kadapa;
      } else if (value == 'Nandyal') {
        return nandyal;
      } else if (value == 'Kurnool') {
        return kurnool;
      } else if (value == 'Anantapur') {
        return anatapur;
      } else if (value == 'Hindupur') {
        return hindupur;
      } else {
        return ['Please select your PC'];
      }
    } else {
      return ['Please select your PC'];
    }
  }

  List<String> srikakulam = [
    'Please select your AC',
    'Ichchapuram',
    'Palasa',
    'Tekkali',
    'Pathapatnam',
    'Srikakulam',
    'Amadalavalasa',
    'Narasannapeta',
  ];
  List<String> vizianagaram = [
    'Please select your AC',
    'Etcherla',
    'Rajam',
    'Bobbili',
    'Cheepurupalle',
    'Gajapathinagaram',
    'Nellimarla',
    'Vizianagaram',
  ];
  List<String> vizag = [
    'Please select your AC',
    'Srungavarapukota',
    'Bhimli',
    'Visakhapatnam East',
    'Visakhapatnam South',
    'Visakhapatnam North',
    'Visakhapatnam West',
    'Gajuwaka',
  ];

  List<String> araku = [
    'Please select your AC',
    'Palakonda',
    'Kurupam',
    'Parvathipuram',
    'Salur',
    'Araku Valley',
    'Paderu',
    'Rampachodavaram',
  ];
  List<String> anakapalli = [
    'Please select your AC',
    'Chodavaram',
    'V.Madugula',
    'Anakapalli',
    'Pendurthi',
    'Elamanchili',
    'Payakaraopeta',
    'Narsipatnam',
  ];
  List<String> rjy = [
    'Please select your AC',
    'Anaparthy',
    'Rajanagaram',
    'Rajahmundry City',
    'Rajamundry Rural',
    'Kovvur',
    'Nidadavole',
    'Gopalapuram',
  ];

  List<String> kkd = [
    'Please select your AC',
    'Tuni',
    'Prathipadu',
    'Pithapuram',
    'Kakinada Rural',
    'Peddapuram',
    'Kakinada City',
    'Jaggampeta',
  ];
  List<String> amp = [
    'Please select your AC',
    'Ramachandrapuram',
    'Mummidivaram',
    'Amalapuram',
    'Razole',
    'Kothapeta',
    'Mandapeta',
    'P. Gannavaram',
  ];
  List<String> eluru = [
    'Please select your AC',
    'Unguturu',
    'Denduluru',
    'Eluru',
    'Polavaram',
    'Chintalapudi',
    'Nuzvid',
    'Kaikalur',
  ];

  List<String> narsapur = [
    'Please select your AC',
    'Achanta',
    'Palacole',
    'Narasapuram',
    'Bhimavaram',
    'Undi',
    'Tanuku',
    'Tadepalligudem',
  ];

  List<String> vjy = [
    'Please select your AC',
    'Tiruvuru',
    'Vijaywada West',
    'Vijayawada Central',
    'Vijayawada East',
    'Mylavaram',
    'Nandigama',
    'Jaggayyapeta',
  ];
  List<String> guntur = [
    'Please select your AC',
    'Prathipadu (SC)',
    'Tadikonda',
    'Mangalagiri',
    'Ponnur',
    'Tenali',
    'Guntur West',
    'Guntur East',
  ];
  List<String> machilipatnam = [
    'Please select your AC',
    'Gannavaram',
    'Gudivada',
    'Pedana',
    'Machilipatnam',
    'Avanigadda',
    'Pamarru',
    'Penamaluru',
  ];
  List<String> baptla = [
    'Please select your AC',
    'Vemuru',
    'Repalle',
    'Bapatla',
    'Parchur',
    'Addanki',
    'Chirala',
    'Santhanuthalapadu',
  ];
  List<String> narsaroapet = [
    'Please select your AC',
    'Pedakurapadu',
    'Chilakaluripet',
    'Narasaraopet',
    'Sattenpalli',
    'Vinukonda',
    'Gurazala',
    'Macherla'
  ];
  List<String> ongole = [
    'Please select your AC',
    'Yerragondapalem',
    'Darsi',
    'Ongole',
    'Kondapi',
    'Markapuram',
    'Giddalur',
    'Kanigiri',
  ];
  List<String> chittor = [
    'Please select your AC',
    'Chandragiri',
    'Nagari',
    'Gangadhara Nellore',
    'Chittoor',
    'Puthalapattu',
    'Palamaner',
    'Kuppam',
  ];
  List<String> nellore = [
    'Please select your AC',
    'Kandukur',
    'Kavali',
    'Atmakur',
    'Kovur',
    'Nellore City',
    'Nellore Rural',
    'Udayagiri',
  ];
  List<String> rajampet = [
    'Please select your AC',
    'Rajampet',
    'Kodur',
    'Rayachoti',
    'Thamballapalle',
    'Pileru',
    'Madanapalle',
    'Punganur',
  ];
  List<String> tirupati = [
    'Please select your AC',
    'Sarvepalli',
    'Gudur',
    'Sullurpeta',
    'Venkatagiri',
    'Tirupati',
    'Srikalahasti',
    'Satyavedu',
  ];
  List<String> anatapur = [
    'Please select your AC',
    'Rayadurg',
    'Uravakonda',
    'Guntakal',
    'Tadipatri',
    'Singanamala',
    'Anantapur Urban',
    'Kalyandurg',
  ];
  List<String> hindupur = [
    'Please select your AC',
    'Raptadu',
    'Madakasira',
    'Hindupur',
    'Penukonda',
    'Puttaparthi',
    'Dharmavaram',
    'Kadiri',
  ];
  List<String> kadapa = [
    'Please select your AC',
    'Badvel',
    'Kadapa',
    'Pulivendla',
    'Kamalapuram',
    'Jammalamadugu',
    'Proddatur',
    'Mydukur',
  ];
  List<String> kurnool = [
    'Please select your AC',
    'Kurnool',
    'Pattikonda',
    'Kodumur',
    'Yemmiganur',
    'Mantralayam',
    'Adoni',
    'Alur',
  ];
  List<String> nandyal = [
    'Please select your AC',
    'Allagadda',
    'Srisailam',
    'Nandikotkur',
    'Panyam',
    'Nandyal',
    'Banaganapalle',
    'Dhone',
  ];

  setZone(String value) {
    if (value == "select your Zone") {
      sZones = '';
      sPc = '';
      return "Please select your Zone";
    } else {
      sZones = value;
      sPc = '';
      sAc = '';
    }
    notifyListeners();
  }

  setPc(String value) {
    sPc = value;
    sAc = '';
    notifyListeners();
  }

  setAc(String value) {
    if (value == 'Please select your AC') {
      sAc = '';
    } else {
      sAc = value;
    }

    notifyListeners();
  }

  setBranding(String value) {
    if (value == 'Please select the type of Branding') {
      typeOfBranding = '';
    } else {
      typeOfBranding = value;
      siteType = "";
    }

    notifyListeners();
  }

  setAreaType(String value) {
    if (value == "Please Select the Area Type") {
      areaType = '';
    } else {
      areaType = value;
    }
    notifyListeners();
  }

  setSiteType(String value) {
    if (value == "Please Select the Site Type") {
      siteType = "";
    } else {
      siteType = value;
    }
    notifyListeners();
  }

  void initLocationSearch(BuildContext context) async {
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    DialogBuilder(context).showLoadingIndicator(
        'Please wait while we are updating your response', '');

    if (!serviceEnabled) {
      // var accept = await openDailog(context);
      // if (accept) {
      serviceEnabled = await location.requestService();
      //   notifyListeners();
      // }

      if (!serviceEnabled) {
        Navigator.of(context, rootNavigator: true).pop();
        showAlert(context, "Error", "Location Service Not Enabled");
        //handleFailureT("Location Service Not Enabled", context);
        notifyListeners();
        return;
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      // var accept = await openDailog(context);
      // if (accept) {

      //   notifyListeners();
      // }
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        Navigator.of(context, rootNavigator: true).pop();
        showAlert(context, "Error", "Location Permission Not Granted");
        //handleFailureT("Location Permission Not Granted", context);
        notifyListeners();
        return;
      } else if (_permissionGranted == PermissionStatus.deniedForever) {
        _permissionGranted = await location.requestPermission();
        notifyListeners();
      }
    }

    _locationData = await location.getLocation();
    lat = _locationData.latitude.toString();
    long = _locationData.longitude.toString();
    if (_locationData.latitude != null) {
      List<geo.Placemark> placemark = await geo.placemarkFromCoordinates(
          _locationData.latitude!, _locationData.longitude!);

      placemark.map((e) {
        locate =
            "${e.name},${e.street},${e.administrativeArea},${e.subAdministrativeArea},${e.locality},${e.subLocality},${e.country},${e.postalCode}";
        // currAddress = Address(
        //     name: e.name,
        //     street: e.street,
        //     iSoCode: e.isoCountryCode,
        //     country: e.country,
        //     postalCode: e.postalCode,
        //     adminArea: e.administrativeArea,
        //     subAdminArea: e.subAdministrativeArea,
        //     locality: e.locality,
        //     subLocality: e.subLocality,
        //     thoroughfare: e.thoroughfare,
        //     subThoroughFare: e.subThoroughfare);

        //print(address.toList());
      }).toList();
    }
    Navigator.of(context, rootNavigator: true).pop();
    showAlert(context, "Success", "Location successfully captured");

    notifyListeners();
  }

  showAlert(BuildContext context, String title, String msg) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: AppConstants.appYellowBG,
            title: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
            ),
            content: Text(
              msg,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          );
        });
  }

  getCamera(BuildContext context) async {
    // pics.clear();
    final firebaseStorage = FirebaseStorage.instance;
    imageSource = ImageSource.camera;
    GetImagePermission getPermission = GetImagePermission.camera();

    bool granted = await getPermission.getPermission(context);
    print(granted.toString());
    if (granted) {
      XFile? image = await imagePicker.pickImage(source: imageSource!,imageQuality: 50);
      if (image != null) {
        var file = File(image.path);
        DialogBuilder(context).showLoadingIndicator('uploading Image', '');
        var snapshot = await firebaseStorage
            .ref()
            .child('images/branding/')
            .child("${vMail.text}_$lat${long}_$index")
            .putFile(file)
            .whenComplete(
                () => Navigator.of(context, rootNavigator: true).pop());
        // .onComplete;
        index++;
        var downloadUrl = await snapshot.ref.getDownloadURL();
        pics.add(downloadUrl);
        notifyListeners();
      }
    } else if (granted == false) {
      //Permission is not granted
      AppConstants.showSnackBar(
          context, "Please grant the permsissions for Camera");
      return;
    }
  }

  submitDetails(BuildContext context) async {
    final databaseReference = FirebaseDatabase.instanceFor(
        app: await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        databaseURL: apiRequest.dbUrlBranding);

    ///updating the details to db.
    DateTime dt = DateTime.now();
    if (vName.text.isNotEmpty &&
        vMail.text.isNotEmpty &&
        sZones.isNotEmpty &&
        sAc.isNotEmpty &&
        sPc.isNotEmpty &&
        lat.isNotEmpty &&
        long.isNotEmpty &&
        pics.isNotEmpty &&
        areaType.isNotEmpty) {
      DialogBuilder(context).showLoadingIndicator(
          'Please wait while we are updating your response', '');
      String s = dt.toIso8601String().splitMapJoin(
        ".",
        onMatch: (p0) {
          return ":";
        },
      );
      Map<String, dynamic> hoard = {
        "Length": "",
        "width": "",
        "Aggregator_name": "",
        "Aggregator_Num": ""
      };
      Map<String, dynamic> pvt = {"Owner_name": "", "Owner_Num": ""};
      if (typeOfBranding == "Hoarding") {
        hoard = {
          "Length": len.text,
          "width": width.text,
          "Aggregator_name": hName.text,
          "Aggregator_Num": hNum.text
        };
      }
      if (typeOfBranding == "Wall Painting") {
        pvt = {"Owner_name": pName.text, "Owner_Num": pNum.text};
      }
      Branding branding = Branding(
          vName: vName.text,
          vMail: vMail.text,
          zone: sZones,
          pc: sPc,
          ac: sAc,
          brandType: typeOfBranding,
          hoarding: hoard,
          pvtWall: pvt,
          noOfPoster: noPosters.text.isNotEmpty ? noPosters.text : "",
          location: locate,
          longitude: long,
          latitude: lat,
          bBranding: pics,
          aBranding: [],
          siteType: siteType,
          areaType: areaType,
          date: s,
          landmark: landmark.text);

      databaseReference
          .ref("/branding")
          .child(s)
          .set(branding.toJson())
          .then((value) {
        Navigator.of(context, rootNavigator: true).pop();
        showAlert(context, "Thank You",
            "Your Response has been recorded successfully");
        enableBTN = false;
        Future.delayed(
            const Duration(seconds: 2),
            () =>
                AppConstants.moveNextClearAll(context, const BrandingScreen()));
      }).catchError((err) {
        Navigator.of(context, rootNavigator: true).pop();
        AppConstants.showSnackBar(context, "$err");
      });
    } else {
      AppConstants.showSnackBar(context, "Please enter all details");
    }
    notifyListeners();
  }
}
