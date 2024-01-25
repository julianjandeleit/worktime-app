import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import the dart:convert library

class UserProvider extends ChangeNotifier {
  User? currentUser;

  UserProvider(this.currentUser);
}
