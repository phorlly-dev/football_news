import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:football_news/core/configs/index.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var hasError = ''.obs;
  var isLoading = false.obs;
  final _auth = Configure.auth;
  final _firestore = FirebaseFirestore.instance;
  final _google = GoogleSignIn.instance;

  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

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
    } on FirebaseAuthException catch (e) {
      hasError.value = _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await _google.authenticate();

    // Obtain the auth details from the request
    final googleAuth = googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(credential);
  }

  // ---------- SIGN OUT ----------
  Future<void> signOut() async {
    await _auth.signOut();
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
