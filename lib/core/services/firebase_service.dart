import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static FirebaseAuth? _auth;
  static FirebaseFirestore? _firestore;

  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
    } catch (_) {
      _auth = null;
      _firestore = null;
    }
  }

  static Future<bool> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    if (_auth == null) return false;

    try {
      await _auth!.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> registerWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    if (_auth == null) return false;

    try {
      final userCredential = await _auth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);
      await _firestore?.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'skinType': 'Combination',
      }, SetOptions(merge: true));

      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> signOut() async {
    try {
      await _auth?.signOut();
    } catch (_) {
      // Ignore sign-out failures when Firebase is not configured.
    }
  }
}
