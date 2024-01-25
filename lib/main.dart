import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart' as pr;
import 'package:work_time_app/sup_auth.dart';
import 'package:work_time_app/viewmodels/ProjectViewModel.dart';
import 'userprovider.dart';
import 'viewmodels/WorkSessionViewModel.dart';
import 'workspace.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
    pr.MultiProvider(
      providers: [
        pr.ChangeNotifierProvider(create: (_) => ProjectViewModel()),
        pr.ChangeNotifierProvider(create: (_) => WorkSessionViewModel()),
        pr.ChangeNotifierProvider(create: (_) => UserProvider(null))
      ],
      child: const WorkTimeApp(),
    ),
  );
}

class WorkTimeApp extends StatelessWidget {
  const WorkTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    //listener to update when user is selected so that current state is showing
    supabase.auth.onAuthStateChange.listen(
      (event) async {
        print("new auth state: ${supabase.auth.currentUser?.id}");
        final projectViewModel =
            pr.Provider.of<ProjectViewModel>(context, listen: false);
        await projectViewModel.updateFromUser();
        projectViewModel.notifyListeners();
      },
    );

    return MaterialApp(
      title: 'WorkTime App',
      navigatorKey: navigatorKey,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.invertedStylus,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
          PointerDeviceKind.touch,
          PointerDeviceKind.unknown
        },
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const SupAuth(),
        '/': (context) => const Workspace(),
      },
    );
  }
}

Future<void> logWarningOrError() async {
  // Set the log level to warning or error
  await Future.delayed(Duration.zero);
  SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
}
