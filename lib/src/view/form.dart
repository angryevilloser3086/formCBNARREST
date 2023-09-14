import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import '../../src/utils/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import '../firebase_options.dart';
import '../network/api_request.dart';
import '../utils/app_utils.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  ApiRequest apiRequest = ApiRequest();
  SharedPref sharedPref = SharedPref();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController vName = TextEditingController();
  TextEditingController vMail = TextEditingController();
  List<String> q1Options = [
    "please select the given options/దయచేసి ఇచ్చిన ఎంపికలను ఎంచుకోండి",
    "అవును/Yes",
    "కాదు/No"
  ];
  List<String> q2Options = [
    "ఇది సరైనది/It is Correct",
    "ఇది తప్పు/It is Wrong",
    "అభిప్రాయం లేదు/No opinion"
  ];
  List<String> q3Options = [
    "చంద్ర బాబు నాయుడు ప్రభుత్వ దౌర్జన్యాలను ప్రశ్నిస్తున్నారు/Questioning the atrocities of government.",
    "కేంద్రంలో బీజేపీ ప్రభావంతో జగన్ చంద్ర బాబు నాయుడును అరెస్ట్ చేయించారు/ Jagan was influenced by BJP at centre to arrest Chandra Babu Naidu.",
    "చంద్ర బాబు నాయుడుకు ప్ర‌జ‌ల నుంచి సానుకూల స్పంద‌న రావ‌డం జ‌గ‌న్ త‌ట్టుకోలేక పోతున్నాడు/Jagan is unable to tolerate the positive response from public to Chandra Babu Naidu.",
    "నాయకత్వాన్ని బలహీనపరిచి టీడీపీని అంతం చేయాలని జగన్ వ్యూహాలు రచిస్తున్నారు/Jagan is plotting to put an end to TDP by breaking the leadership.",
    "జగన్ అహంకార ధోరణి ఈ అరెస్ట్ నిదర్శనం/Ego centric attitude of Jagan let this arrest happen.",
    "చంద్ర బాబు నాయుడుకు వ్యతిరేకంగా ప్రభుత్వం బలమైన సాక్ష్యాలను సేకరించింది/Government has actually collected the strong evidences against Chandra Babu Naidu."
  ];

  List<String> q4Options = [
    "పోలీసులు విపరీతంగా వ్యవహరించారు మరియు అరెస్టు సమయంలో నిర్దాక్షిణ్యంగా వ్యవహరించారు/Police acted Extreme and were ruthless in their behaviour during arrest",
    "వారు నియమాలను అనుసరించారు/Followed rules",
    "పోలీసుల ప్రవర్తన గురించి తెలియదు/Unaware of Police behaviour"
  ];

  List<String> q5Options = [
    "బలమైన కూటమి అయితే,  వైఎస్సార్‌సీపీని ఓడించలేదు/Strong alliance, but YSRCP cannot be defeated",
    "బలమైన కూటమి,  వైఎస్సార్‌సీపీని ఓడించగలదు/ Strong Alliance, can defeat YSRCP",
    'వైఎస్సార్‌సీపీ, కూటమిని ఓడించగలదు/YSRCP can defeat the alliance',
    "చెప్పలేను/Can't say"
  ];

  List<String> q6Options = [
    "అవును/Yes",
    "కాదు/No",
    "చెప్పలేను/Can't say",
    "ఇది కూటమిని బలహీనపరుస్తుంది/It will weaken the alliance"
  ];

  List<String> q7Options = [
    "Please select your constituency",
    'Araku Valley/అరకు లోయ',
    'Paderu/పాడేరు',
    'Rampachodavaram/రంపచోడవరం',
    'Chodavaram/చోడవరం',
    'Madugula/మాడుగుల',
    'Anakapalle/అనకాపల్లి',
    'Pendurthi/పెందుర్తి',
    'Elamanchili/ఎలమంచిలి',
    'Payakaraopet/పాయకరావుపేట',
    'Narsipatnam/నర్సీపట్నం',
    'Rayadurg/రాయదుర్గ్',
    'Uravakonda/ఉరవకొండ',
    'Guntakal/గుంతకల్',
    'Tadipatri/తాడిపత్రి',
    'Singanamala/సింగనమల',
    'Anantapur Urban/అనంతపూర్ అర్బన్',
    'Kalyandurg/కళ్యాణదుర్గ్',
    'Raptadu/రాప్తాడు',
    'Vemuru/వేమూరు',
    'Repalle/రేపల్లె',
    'Bapatla/బాపట్ల',
    'Parchur/పర్చూరు',
    'Addanki/అద్దంకి',
    'Chirala/చీరాల',
    'Rajampeta/రాజంపేట',
    'Kodur/కోడూరు',
    'Rayachoti/రాయచోటి',
    'Thamballapalle/తంబళ్లపల్లె',
    'Pileru/పీలేరు',
    'Madanapalle/మదనపల్లె',
    'Punganur/పుంగనూరు',
    'Nagari/నగరి',
    'Gangadhara Nellore/గంగాధర  నెల్లూరు',
    'Chittoor/చిత్తూర్',
    'Puthalapattu/పూతలపట్టు',
    'palamaner/పలమనేరు',
    'Kuppam/కుప్పం',
    'Anaparthy/అనపర్తి',
    'Rajanagaram/రాజానగరం',
    'Rajamundry City/రాజమండ్రి సిటీ',
    'Rajahmundry Rural/రాజమండ్రి గ్రామీణ',
    'Kovvur/కొవ్వూరు',
    'Nidadavole/నిడదవోలే',
    'Gopalapuram/గోపాలపురం',
    'Unguturu/ఉంగుటూరు',
    'Denduluru/దెందులూరు',
    'Eluru/ఏలూరు',
    'Polavaram/పోలవరం',
    'Chintalapudi/చింతలపూడి',
    'Nuzvid/నూజివీడు',
    'Kaikalur/కైకలూరు',
    'Tadikonda/తాడికొండ',
    'Mangalagiri/మంగళగిరి',
    'Ponnuru/పొన్నూరు',
    'Tenali/తెనాలి',
    'Prathipadu/ప్రత్తిపాడు',
    'Guntur West/గుంటూరు పశ్చిమ',
    'Guntur East/గుంటూరు తూర్పు',
    'Achanta/ఆచంట',
    'Palakollu/పాలకొల్లు',
    'Narasapuram/నరసాపురం',
    'Bhimavaram/భీమవరం',
    'Undi/ఉండీ',
    'Tanuku/తణుకు',
    'Tadepalligudem/తాడేపల్లిగూడెం',
    'Rajam/రాజం',
    'Bobbili/బొబ్బిలి',
    'Cheepurupalli/చీపురుపల్లి',
    'Gajapathinagaram/గజపతినగరం',
    'Nellimarla/నెల్లిమర్ల',
    'Vizianagaram/విజయనగరం',
    'Srungavarapukota/శృంగవరపుకోట',
    'Bhimili/భీమిలి',
    'Vishakapatnam East/విశాఖపట్నం తూర్పు',
    'Vishakapatnam West/విశాఖపట్నం పడమర',
    'Vishakapatnam South/విశాఖపట్నం దక్షిణ',
    'Vishakapatnam North/విశాఖపట్నం ఉత్తరం',
    'Gajuwaka/గాజువాక',
    'Gudur/గూడూరు',
    'Sullurupeta/సూళ్లూరుపేట',
    'Venkatagiri/వెంకటగిరి',
    'Chandragiri/చంద్రగిరి',
    'Sullurpeta/సూళ్లూరుపేట',
    'Srikalahasti/శ్రీకాళహస్తి',
    'Sathyavedu/సత్యవేడు',
    'Ichchapuram/ఇచ్ఛాపురం',
    'Palasa/పలాస',
    'Tekkali/టెక్కలి',
    'Pathapatnam/పాతపట్నం',
    'Srikakulam/శ్రీకాకుళం',
    'Amadalavalasa/ఆమదాలవలస',
    'Etcherla/ఎచ్చెర్ల',
    'Narasannapeta/నరసన్నపేట',
    'Madakasira/మడకశిర',
    'Hindupur/హిందూపూర్',
    'Penukonda/పెనుకొండ',
    'Puttaparthi/పుట్టపర్తి',
    'Dharmavaram/ధర్మవరం',
    'Kadiri/కదిరి',
    'Yerragondapalem/యర్రగొండపాలెం',
    'Darsi/దర్శి',
    'Santhanuthalapadu/సంతనూతలపాడు',
    'Ongole/ఒంగోలు',
    'Kondapi/కొండపి',
    'Markapuram/మార్కాపురం',
    'Giddalur/గిద్దలూరు',
    'Kanigiri/కనిగిరి',
    'Pedakurapadu/పెదకూరపాడు',
    'Chilakaluripeta/చిలకలూరిపేట',
    'Narasaraopet/నరసరావుపేట',
    'Sattenapalle/సత్తెనపల్లె',
    'Vinukonda/వినుకొండ',
    'Gurajala/గురజాల',
    'Macherla/మాచర్ల',
    'Tiruvuru/తిరువూరు',
    'Vijayawada West/విజయవాడ పడమర',
    'Vijayawada Central/విజయవాడ సెంట్రల్',
    'Vijayawada East/విజయవాడ తూర్పు',
    'Mylavaram/మైలవరం',
    'Nandigama/నందిగామ',
    'Jaggayyapeta/జగ్గయ్యపేట',
    'Kandukur/కందుకూరు',
    'Kavali/కావలి',
    'Atmakur/ఆత్మకూర్',
    'Kovur/కోవూరు',
    'Nellore City/నెల్లూరు సిటీ',
    'Nellore Rural/నెల్లూరు రూరల్',
    'Sarvepalli/సర్వేపల్లి',
    'Udayagiri/ఉదయగిరి',
    'Allagadda/ఆళ్లగడ్డ',
    'Srisailam/శ్రీశైలం',
    'Nandikotkur/నందికొట్కూరు',
    'Panyam/పాణ్యం',
    'Nandyal/నంద్యాల',
    'Banaganapalle/బనగానపల్లె',
    'Dhone/ధోన్',
    'Badvel/బద్వేల్',
    'Kadapa/కడప',
    'Pulivendla/పులివెందుల',
    'Kamalapuram/కమలాపురం',
    'Jammalamadugu/జమ్మలమడుగు',
    'Mydukur/మైదుకూరు',
    'Proddatur/ప్రొద్దుటూరు',
    'Tuni/తుని',
    'Prathipadu/ప్రత్తిపాడు',
    'Pithapuram/పిఠాపురం',
    'Kakinada Rural/కాకినాడ గ్రామీణ',
    'Peddapuram/పెద్దాపురం',
    'Kakinada City/కాకినాడ నగరం',
    'Jaggampeta/జగ్గంపేట',
    'Ramachandrapuram/రామచంద్రపురం',
    'Mummidivaram/ముమ్మిడివరం',
    'Amalapuram/అమలాపురం',
    'Razole/రజోల్',
    'Gannavaram (konaseema)/గన్నవరం',
    'Kothapeta/కొత్తపేట',
    'Mandapeta/మండపేట',
    'Gannavaram/గన్నవరం',
    'Gudivada/గుడివాడ',
    'Pedana/పెడన',
    'Machilipatnam/మచిలీపట్నం',
    'Avanigadda/అవనిగడ్డ',
    'Pamarru/పామర్రు',
    'Penamaluru/పెనమలూరు',
    'Kurnool/కర్నూలు',
    'Pattikonda/పత్తికొండ',
    'Kodumur/కోడుమూరు',
    'Yemmiganur/యెమ్మిగనూరు',
    'Mantralayam/మంత్రాలయం',
    'Adoni/ఆదోని',
    'Alur/ఆలూర్',
    'Palakonda/పాలకొండ',
    'Kurupam/కురుపాం',
    'Parvathipuram/పార్వతీపురం',
    'Salur/సాలూరు',
  ];

  String q1Answer = '';
  String q2Answer = '';
  String q3Answer = '';
  String q4Answer = '';
  String q5Answer = '';
  String q6Answer = '';
  String q7Answer = '';

  int selectedGRadio = -1;
  int selectedq2Radio = -1;
  int selectedq3Radio = -1;
  int selectedq4Radio = -1;
  int selectedq5Radio = -1;
  int selectedq6Radio = -1;
  int selectedq7Radio = -1;
  String vNam = '';
  String vNum = '';
  bool enableBTN = true;

  @override
  initState() {
    init();
    super.initState();
  }

  init() async {
    vNam = await sharedPref.read("name");
    vNum = await sharedPref.read("mail");
    setState(() {
      vName = TextEditingController(text: vNam);
      vMail = TextEditingController(text: vNum);
    });

    //print(vNam + vName.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
            "సీబీఎన్ అరెస్టుపై ప్రజాభిప్రాయం/Public Opinion on CBN Arrest",
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
      ),
      backgroundColor: Colors.yellowAccent,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: AppConstants.all_20,
          child: Form(
            child: Column(
              children: [
                p3VNAME(context, "వాలంటీర్ పేరు/Name of the Volunteer"),
                p3VMail(context, "వాలంటీర్ యొక్క మెయిల్/Mail of the Volunteer"),
                p3q6(context, "ప్రతిస్పందనదారు పేరు/Name of the responder"),
                p4q1(context,
                    "1. చంద్రబాబు నాయుడు అరెస్టు గురించి మీకు తెలుసా?/Do you know about the arrest of Chandra Babu Naidu?"),
                p4q2(
                  context,
                  "2. చంద్రబాబు నాయుడు అరెస్టుపై మీరేమంటారు?/What do you think about the arrest of Chandra Babu Naidu?",
                ),
                p4q3(
                  context,
                  "3.చంద్ర బాబు నాయుడు ఎందుకు అరెస్ట్ అయ్యార ని అనుకుంటున్నారు?/Why do you think he was arrested?",
                ),
                p4q4(
                  context,
                  "4. అరెస్టు సమయంలో పోలీసులు ఎలా ప్రవర్తించారు?/How did the Police behave during his arrest?",
                ),
                p4q5(
                  context,
                  "5. టీడీపీ-జేఎస్పీ మధ్య పొత్తు గురించి మీరు ఏమనుకుంటున్నారు?/ What do you think about the alliance between JSP and TDP?",
                ),
                p4q6(context,
                    "6.టీడీపీ-జేఎస్పీ కూటమితో బీజేపీ కలిస్తే పొత్తు బలపడుతుందా?/If BJP join with TDP- JSP alliance, will the alliance be stronger?"),
                p4q7(context,
                    "ప్రతిస్పందించే వ్యక్తి యొక్క ఫోన్ నెంబరు/Phone Number of the Responder"),
                p4q8(context,
                    "మీరు ఏ నియోజకవర్గానికి చెందినవారు?/Which Constituency do you belong to?"),
                AppConstants.h_10,
                if (enableBTN)
                  InkWell(
                    onTap: () {
                      //if(name.text.isNotEmpty&& number.text.isNotEmpty&&q1Answer.isNotEmpty&&q2Answer.isNotEmpty)
                      updateDetails();
                    },
                    child: btn(context, "Submit"),
                  )
              ],
            ),
          ),
        ),
      )),
    );
  }

  p3q6(BuildContext context, String title) {
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

  p3VNAME(BuildContext context, String title) {
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
                controller: vName,
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

  p3VMail(BuildContext context, String title) {
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
                controller: vMail,
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

  p4q1(BuildContext context, String title) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 150,
                  child: ListTileTheme(
                    minLeadingWidth: 0,
                    minVerticalPadding: 0,
                    horizontalTitleGap: 5,
                    child: RadioListTile<int>(
                      contentPadding: AppConstants.leftRight_5,
                      value: 1,
                      groupValue: selectedGRadio,
                      activeColor: Colors.black,
                      onChanged: (int? val) {
                        setState(() {
                          selectedGRadio = val!;
                          q1Answer = "Yes";
                        });
                      },
                      title: Text(
                        "అవును/Yes",
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ListTileTheme(
                    minLeadingWidth: 0,
                    horizontalTitleGap: 5,
                    child: RadioListTile<int>(
                      contentPadding: AppConstants.leftRight_5,
                      value: 2,
                      groupValue: selectedGRadio,
                      activeColor: Colors.black,
                      onChanged: (int? val) {
                        setState(() {
                          selectedGRadio = val!;
                          q1Answer = "No";
                        });
                      },
                      title: Text("కాదు/No",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  p4q2(BuildContext context, String title) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: q2Options.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 150,
                        child: ListTileTheme(
                          minLeadingWidth: 0,
                          minVerticalPadding: 0,
                          horizontalTitleGap: 5,
                          child: RadioListTile<int>(
                            contentPadding: AppConstants.leftRight_5,
                            value: index,
                            groupValue: selectedq2Radio,
                            activeColor: Colors.black,
                            onChanged: (int? val) {
                              setState(() {
                                selectedq2Radio = val!;
                                q2Answer = q2Options[index];
                              });
                            },
                            title: Text(
                              q2Options[index],
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  p4q3(BuildContext context, String title) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: q3Options.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 150,
                        child: ListTileTheme(
                          minLeadingWidth: 0,
                          minVerticalPadding: 0,
                          horizontalTitleGap: 5,
                          child: RadioListTile<int>(
                            contentPadding: AppConstants.leftRight_5,
                            value: index,
                            groupValue: selectedq3Radio,
                            activeColor: Colors.black,
                            onChanged: (int? val) {
                              setState(() {
                                selectedq3Radio = val!;
                                q3Answer = q3Options[index];
                              });
                            },
                            title: Text(
                              q3Options[index],
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  p4q4(BuildContext context, String title) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: q4Options.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 150,
                        child: ListTileTheme(
                          minLeadingWidth: 0,
                          minVerticalPadding: 0,
                          horizontalTitleGap: 5,
                          child: RadioListTile<int>(
                            contentPadding: AppConstants.leftRight_5,
                            value: index,
                            groupValue: selectedq4Radio,
                            activeColor: Colors.black,
                            onChanged: (int? val) {
                              setState(() {
                                selectedq4Radio = val!;
                                q4Answer = q4Options[index];
                              });
                            },
                            title: Text(
                              q4Options[index],
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  p4q5(BuildContext context, String title) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: q5Options.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 150,
                        child: ListTileTheme(
                          minLeadingWidth: 0,
                          minVerticalPadding: 0,
                          horizontalTitleGap: 5,
                          child: RadioListTile<int>(
                            contentPadding: AppConstants.leftRight_5,
                            value: index,
                            groupValue: selectedq5Radio,
                            activeColor: Colors.black,
                            onChanged: (int? val) {
                              setState(() {
                                selectedq5Radio = val!;
                                q5Answer = q5Options[index];
                              });
                            },
                            title: Text(
                              q5Options[index],
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  p4q6(BuildContext context, String title) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: q6Options.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 150,
                        child: ListTileTheme(
                          minLeadingWidth: 0,
                          minVerticalPadding: 0,
                          horizontalTitleGap: 5,
                          child: RadioListTile<int>(
                            contentPadding: AppConstants.leftRight_5,
                            value: index,
                            groupValue: selectedq6Radio,
                            activeColor: Colors.black,
                            onChanged: (int? val) {
                              setState(() {
                                selectedq5Radio = val!;
                                q6Answer = q6Options[index];
                              });
                            },
                            title: Text(
                              q5Options[index],
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  p4q8(BuildContext context, String title) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(title,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: AppConstants.boxBorderDecoration2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    dropdownColor: Colors.white,
                    borderRadius: AppConstants.boxRadius8,
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    isExpanded: true,
                    value: q7Answer.isEmpty ? q7Options.first : q7Answer,
                    items:
                        q7Options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: AppConstants.all_10,
                          child: Text(value,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        q7Answer = value!;
                      });
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  p4q7(BuildContext context, String title) {
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
                keyboardType: TextInputType.number,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //controller: addNewPeople.fnameController,
              ),
            ),
          ],
        ),
      ),
    );
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

  updateDetails() async {
    DateTime dt = DateTime.now();
    String lat = '';
    String longitude = '';
    if (kIsWeb) {
      LocationData ld = await getLocation();
      setState(() {
        lat = ld.latitude.toString();
        longitude = ld.longitude.toString();
      });
    }
    if (Platform.isAndroid || Platform.isIOS) {
      Position pos = await determinePosition();
      setState(() {
        lat = pos.latitude.toString();
        longitude = pos.longitude.toString();
      });
    }

    final databaseReference = FirebaseDatabase.instanceFor(
        app: await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        databaseURL: apiRequest.dbUrl);

    Map<String, dynamic> answers = {};
    setState(() {
      answers = {
        "date": dt.toIso8601String(),
        "Name of the responder": name.text,
        "Do you know about the arrest of Chandra Babu Naidu?": q1Answer,
        "What do you think about the arrest of Chandra Babu Naidu?": q2Answer,
        "Why do you think he was arrested?": q3Answer,
        "How did the Police behave during his arrest?": q4Answer,
        "What do you think about the alliance between JSP and TDP?": q5Answer,
        "If BJP join with TDP-JSP alliance, will the alliance be stronger?":
            q6Answer,
        "Phone Number of the Responder": number.text,
        "Which Constituency do you belong to?": q7Answer,
        "Longitude": longitude,
        "Latitude": lat,
        "vname": vName.text,
        "vMail": vMail.text
      };
    });
    String s = dt.toIso8601String().splitMapJoin(
      ".",
      onMatch: (p0) {
        return ":";
      },
    );

    databaseReference.ref("/cbn_arrest").child(s).set(answers).then((value) {
      AppConstants.showSnackBar(context, "Thanks for the Feedback");
      showAlert(context, "ధన్యవాదాలు/Thank You",
          "మీ అభిప్రాయం విజయవంతంగా నమోదు చేయబడింది/Your opinion has been recorded successfully");
      setState(() {
        enableBTN = false;
      });
      Future.delayed(const Duration(seconds: 5),
          () => AppConstants.moveNextClearAll(context, const FormScreen()));
    }).catchError((err) {
      AppConstants.showSnackBar(context, "$err");
    });
    // print(jsonEncode(answers));
  }

  LocationData? _location;
  String? _error;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<LocationData> getLocation() async {
    Location location = Location();
    setState(() {
      _error = null;
    });
    try {
      final locationResult = await location.getLocation();
      setState(() {
        _location = locationResult;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
    return _location!;
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
}
