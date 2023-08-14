import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:work_time_app/firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_options.dart';
import 'login.dart';
import 'workspace.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure authentication persistence
  // somehow makes freeze on startup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
      clientId: DefaultFirebaseOptions.currentPlatform.appId);

  var fo = DefaultFirebaseOptions.currentPlatform;
  //print("client id ${fo.apiKey} ${fo.apiKey}");
  runApp(WorkTimeApp(googleSignIn: googleSignIn));
}

class WorkTimeApp extends StatelessWidget {
  final GoogleSignIn googleSignIn;

  WorkTimeApp({required this.googleSignIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkTime App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}
