import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Validators {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email can not be empty';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password can not be empty';
    }
    return null;
  }

  static String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Username cannot be empty';
    }
    if (value.length < 4) {
      return 'Username must be at least 4 characters long';
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Username must not contain special characters';
    }
    return null;
  }

  static Future<bool> checkUsernameExistsInDB(String username) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return snapshot.docs.isNotEmpty;
  }
}
