import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class SupAuth extends StatelessWidget {
  const SupAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    return Scaffold(
        appBar:
            AppBar(title: Text('Authentication ${Uri.base.origin.toString()}')),
        body: Center(
            child: Column(
          children: [
            Text(supabase.auth.currentUser?.email ?? "Please log in"),
            SupaSocialsAuth(
              socialProviders: const [SocialProviders.google],
              colored: true,
              showSuccessSnackBar: true,
              redirectUrl: Uri.base.origin
                  .toString(), // uri of this page using Uri.base somehow gets not recognized because of frament (#access_token=...) maybe
              onSuccess: (p0) {
                print("succeess ${Uri.base.toString()}");
                //NOTE: why is this not being called? -> because domain need to be in allowed list in supabase

                //somehow only called when already logged in. maybe because redirect doesn't work properly?
                Navigator.pushNamed(context, "/");
              },
              onError: (error) {
                print("error");
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/");
                },
                child: const Text("continue without login"))
          ],
        )));
  }
}
