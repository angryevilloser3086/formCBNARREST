import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    "It is Correct/ఇది సరైనది",
    "It is Wrong/ఇది తప్పు",
    "No opinion/అభిప్రాయం లేదు"
  ];
  List<String> q3Options = [
    "రాజకీయంగా ప్రేరేపించబడింది/Politically motivated",
    "జగన్ కి ఓటమి భయం పట్టుకుంది/Jagan is afraid of his defeat",
    "జగన్ అరెస్టుకు టిట్ ఫర్ టాట్/Tit for Tat for Jagan's arrest",
    "న్యాయబద్దమైన అరెస్ట్../Genuine Arrest",
    "చంద్రబాబు నాయుడు అవినీతికి పాల్పడ్డాడు/Chandra Babu Naidu was involved in corruption",
    "అభిప్రాయం లేదు/No Opinion"
  ];

  List<String> q4Options = [
    "పోలీసులు విపరీతంగా వ్యవహరించారు మరియు అరెస్టు సమయంలో నిర్దాక్షిణ్యంగా వ్యవహరించారు/Police acted Extreme and were ruthless in their behaviour during arrest",
    "వారు నియమాలను అనుసరించారు/Followed rules",
    "పోలీసుల ప్రవర్తన గురించి తెలియదు/Unaware of Police behaviour"
  ];

  List<String> q5Options = [
    "సీబీఎన్ కు బెయిల్ రాకముందే కనీసం 2 రోజులు జైల్లో ఉంచాలని/To keep him jailed at least for 2 days before CBN gets Bail",
    "పోలీసు కస్టడీలో అతనిని గాయపరచడానికి/To hurt him in Police custody",
    "శనివారం అరెస్టుకు సరైన  కారణం లేదు/No logical reason for Saturday's arrest",
    "చంద్రబాబు నాయుడిపై సత్వర చర్యలు తీసుకోవాలని జగన్ సర్కార్ భావించింది/Jagan's Government wanted to take swift action against Chandrababu Naidu",
    "అభిప్రాయం లేదు/No Opinion"
  ];

  List<String> q6Options = [
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

  int selectedGRadio = -1;
  int selectedq2Radio = -1;
  int selectedq3Radio = -1;
  int selectedq4Radio = -1;
  int selectedq5Radio = -1;
  int selectedq6Radio = -1;
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
                    "చంద్రబాబు నాయుడు అరెస్టు గురించి మీకు తెలుసా?/Do you know about the arrest of Chandra Babu Naidu?"),
                p4q2(
                  context,
                  "చంద్రబాబు నాయుడు అరెస్టుపై మీరేమంటారు?/What do you think about the arrest of Chandra Babu Naidu?",
                ),
                p4q3(
                  context,
                  "అతని అరెస్టు వెనుక ఉద్దేశ్యం ఏమిటని మీరు అనుకుంటున్నారు?/What do you think is the motive behind his arrest?",
                ),
                p4q4(
                  context,
                  "అరెస్టు సమయంలో పోలీసులు ఎలా ప్రవర్తించారు?/How did the Police behave during his arrest?",
                ),
                p4q5(
                  context,
                  "శనివారం సీబీఎన్ ను పోలీసులు ఎందుకు అరెస్టు చేశారు?/Why do you think the Police arrested CBN on Saturday?",
                ),
                p4q7(context,
                    "ప్రతిస్పందించే వ్యక్తి యొక్క ఫోన్ నెంబరు/Phone Number of the Responder"),
                p4q6(context,
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
                    value: q6Answer.isEmpty ? q6Options.first : q6Answer,
                    items:
                        q6Options.map<DropdownMenuItem<String>>((String value) {
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
                        q6Answer = value!;
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
    LocationData ld = await getLocation();

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
        "What do you think is the motive behind his arrest?": q3Answer,
        "How did the Police behave during his arrest?": q4Answer,
        "Why do you think the Police arrested CBN on Saturday?": q5Answer,
        "Phone Number of the Responder": number.text,
        "Which Constituency do you belong to?": q6Answer,
        "Longitude": ld.longitude,
        "Latitude": ld.latitude,
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
