import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:work_time_app/firebase_options.dart';
import 'package:work_time_app/models/WorkSession.dart';
import 'package:work_time_app/sup_auth.dart';
import 'package:work_time_app/viewmodels/ProjectViewModel.dart';
import 'models/Project.dart';
import 'models/basic_list.dart';
import 'userDataProvider.dart';
import 'login.dart';
import 'viewmodels/WorkSessionViewModel.dart';
import 'workspace.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://wudetldwulxvzcjnyjcz.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind1ZGV0bGR3dWx4dnpjam55amN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI1NDA4MjAsImV4cCI6MjAwODExNjgyMH0.UhJ-Cq55JIN87E5tlE_r7V-woRNKA8ZCaEzmywzupqQ",
  );
  // SystemChannels.lifecycle.setMessageHandler((message) async {
  //   if (message == AppLifecycleState.resumed.toString()) {
  //     // Set the log level to warning or error
  //     await logWarningOrError();
  //   }
  // });
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // final GoogleSignIn googleSignIn = GoogleSignIn(
  //     scopes: ['email'],
  //     clientId: DefaultFirebaseOptions.currentPlatform.appId);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => ProjectViewModel()),
        ChangeNotifierProvider(create: (_) => WorkSessionViewModel())
      ],
      child: WorkTimeApp(),
    ),
  );
}

class WorkTimeApp extends StatelessWidget {
  WorkTimeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkTime App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => SupAuth(),
        '/': (context) => WorkTimeApp(),
      },
    );
  }
}

Future<void> logWarningOrError() async {
  // Set the log level to warning or error
  await Future.delayed(Duration.zero);
  SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
}
