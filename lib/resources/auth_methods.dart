import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_social/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // sign up user
  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? profileImage,
  }) async {
    String res = "Some error occurred!";
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty
          // profileImage != null
          ) {
        // register the user
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String photoUrl = '';
        if (profileImage != null) {
          photoUrl = await StorageMethods()
              .uploadImage('profilePics', profileImage, false);
        }
        // add user to firestore
        await _firestore.collection('users').doc(credentials.user!.uid).set({
          'username': username,
          'uid': credentials.user!.uid,
          'bio': bio,
          'email': email,
          'photoUrl': photoUrl,
          'followers': [],
          'following': []
        });
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (err.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else if (err.code == 'invalid-email') {
        res = 'The email address is badly formatted.';
      } else {
        res = err.toString();
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred!";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // login the user
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'wrong-password') {
        res = 'The password is invalid.';
      } else if (err.code == 'user-not-found') {
        res =
            'There is no user record corresponding to this identifier. The user may have been deleted.';
      } else if (err.code == 'user-disabled') {
        res = 'The user account has been disabled by an administrator.';
      } else {
        res = err.toString();
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
