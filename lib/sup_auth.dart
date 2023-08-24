import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:work_time_app/userprovider.dart';
import 'package:provider/provider.dart' as pr;

class SupAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    return Scaffold(
        appBar: AppBar(title: Text('Authentication')),
        body: Center(
            child: Column(
          children: [
            Text(supabase.auth.currentUser?.email ?? "no user"),
            SupaSocialsAuth(
              socialProviders: [SocialProviders.google],
              colored: true,
              showSuccessSnackBar: true,
              redirectUrl: "/", //somehow this has no effect. or does it??
              onSuccess: (p0) {
                //print("succeess ${Uri.base.toString()}");
                //TODO: why is this not being called?
                //Navigator.pushNamed(context, "/");
              },
              onError: (error) {
                print("error");
              },
            ),
          ],
        )));
  }
}
