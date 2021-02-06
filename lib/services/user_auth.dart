import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  Future<UserCredential> signUp(String mail, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: mail, password: password);
  }

  Future<UserCredential> signIn(String mail, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: mail, password: password);
  }

  uploadUserData(UserModel user) async {
    await _store.collection("users").doc(user.userId).set(user.toJson());
  }

  User getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
