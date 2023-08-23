import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

import 'viewmodels/ProjectViewModel.dart'; // Import the dart:convert library

class UserProvider extends ChangeNotifier {
  User? currentUser;

  UserProvider(this.currentUser);
}
