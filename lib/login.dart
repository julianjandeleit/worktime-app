import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => signInAnonymously(context),
              child: Text('Sign In Anonymously'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => signInWithGoogle(context),
              child: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
      print("Anonymous sign-in successful!");
      Navigator.pushReplacementNamed(
          context, '/main'); // Navigate to MainScreen
    } catch (error) {
      print("Error during anonymous sign-in: $error");
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      var credential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);

      await _auth.signInWithCredential(credential.credential!);
      Navigator.pushReplacementNamed(
          context, '/main'); // Navigate to MainScreen
    } catch (error) {
      print("Error during Google sign-in: $error");
    }
  }
}
