import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:football_news/core/configs/index.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var hasError = ''.obs;
  var infoMessage = ''.obs;
  var isLoading = false.obs;
  final _auth = Configure.auth;
  final _firestore = FirebaseFirestore.instance;
  final _facebook = FacebookAuth.instance;
  final _google = Configure.signIn;

  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  bool get isLoggedIn => firebaseUser.value != null;

  // ---------- SIGN UP ----------
  Future<void> signUp({required String email, required String password}) async {
    isLoading.value = true;
    hasError.value = ''; // reset
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally store user profile in Firestore
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'email': email,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });
      infoMessage.value = 'Account Created.';
    } on FirebaseAuthException catch (e) {
      hasError.value = _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  // ---------- SIGN IN ----------
  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    hasError.value = ''; // reset
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      infoMessage.value = 'Welcome Back!';
    } on FirebaseAuthException catch (e) {
      hasError.value = _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final googleUser = await _google.authenticate();

      // Obtain the auth details from the request
      final googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await _auth.signInWithCredential(credential);

      debugPrint('✅ Signed in as: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth error: ${e.message}');
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
    }
  }

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    final result = await _facebook.login();

    if (result.status == LoginStatus.success) {
      final accessToken = result.accessToken!;
      final credential = FacebookAuthProvider.credential(
        accessToken.tokenString,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      debugPrint('✅ Signed in as: ${userCredential.user?.email}');
    } else {
      print('Facebook login failed: ${result.status}');
    }
  }

  // ---------- SIGN OUT ----------
  Future<void> signOut() async {
    await _auth.signOut();
    await _google.signOut();
    await _facebook.logOut();
  }

  // ---------- ERROR HANDLER ----------
  String _handleError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email format';
      case 'email-already-in-use':
        return 'Email already in use';
      case 'weak-password':
        return 'Password too weak';
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Incorrect password';
      default:
        return e.message ?? 'Unexpected error';
    }
  }
}
