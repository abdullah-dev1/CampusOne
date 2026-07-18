import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //=============================
  // Login
  //=============================

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //=============================
  // Logout
  //=============================

  Future<void> logout() async {
    await _auth.signOut();
  }

  //=============================
  // Current User
  //=============================

  User? get currentUser {
    return _auth.currentUser;
  }

  //=============================
  // User Document
  //=============================

  Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserDocument() async {
    return await _firestore.collection("users").doc(currentUser!.uid).get();
  }

  //=============================
  // Forgot Password
  //=============================

  Future<void> sendResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}