import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:work_time_app/firebase_options.dart';
import 'package:work_time_app/models/WorkSession.dart';
import 'package:work_time_app/viewmodels/ProjectViewModel.dart';
import 'userDataProvider.dart';
import 'login.dart';
import 'viewmodels/WorkSessionViewModel.dart';
import 'workspace.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
      clientId: DefaultFirebaseOptions.currentPlatform.appId);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => ProjectViewModel()),
        ChangeNotifierProvider(create: (_) => WorkSessionViewModel())
      ],
      child: WorkTimeApp(googleSignIn: googleSignIn),
    ),
  );
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
      initialRoute: '/main',
      routes: {
        '/': (context) => AuthScreen(),
        '/main': (context) => Workspace(),
      },
    );
  }
}
