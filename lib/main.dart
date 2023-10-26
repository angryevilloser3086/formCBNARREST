import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/firebase_options.dart';
import 'src/network/api_request.dart';

const USE_DATABASE_EMULATOR = true;
// The port we've set the Firebase Database emulator to run on via the
// `firebase.json` configuration file.
const emulatorPort = 9000;
// Android device emulators consider localhost of the host machine as 10.0.2.2
// so let's use that if running on Android.
final emulatorHost =
    (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
        ? '10.0.2.2'
        : 'localhost';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  ApiRequest apiRequest = ApiRequest();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (USE_DATABASE_EMULATOR) {
    //FirebaseDatabase.instance.useDatabaseEmulator(emulatorHost, emulatorPort);
    FirebaseDatabase.instanceFor(
        app: await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        databaseURL: apiRequest.dbUrl);
  }
  runApp(const MyApp());
}
