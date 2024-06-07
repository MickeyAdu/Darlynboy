import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "./models/user_model.dart";

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestorage = FirebaseFirestore.instance;
  static bool isLoading = false;

  Future<UserModel> getUserDetails() async {
    DocumentSnapshot snapshot = await _firestorage
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();

    return UserModel.fromMap(snapshot as Map<String, dynamic>);
  }

  // Sign up method
  Future<String> signUp({
    required String fullName,
    required String email,
    required String password,
    // required String badgeNumber,
  }) async {
    String result = 'Some error occured';
    if (fullName.isNotEmpty ||
        email.isNotEmpty ||
        // file.isNotEmpty ||
        password.isNotEmpty) {
      try {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (credential.user != null) {
          UserModel user = UserModel(
              email: email,
              // badgeNumber: badgeNumber,
              uid: credential.user!.uid,
              fullName: fullName);

          await _firestorage.collection('users').doc(credential.user!.uid).set(
                user.toMap(),
              );
          result = 'Successful';
        }
      } catch (err) {
        result = err.toString();
        // ignore: avoid_print
        // print('Errrorrr');
        debugPrint(err.toString());
      }
    }
    return result;
  }

  Future<bool> loginUser(String password, String email) async {
    bool result = false;

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // debugPrint(credential.user as String?);
      if (credential.user != null) {
        result = true;
      }
    } on FirebaseAuthException {
      throw Exception;
    } catch (err) {
      result = false;

      debugPrint(" err.toString() ${err.toString()}");
    }

    return result;
  }

  signOut() {
    _auth.signOut();
  }
}
