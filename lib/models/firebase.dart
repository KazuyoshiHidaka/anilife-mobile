import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Firebase {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore fireStore = Firestore.instance;
  FirebaseUser currentUser;

  Future<void> setCurrentUser() async {
    currentUser = await auth.currentUser();
  }

  Future<void> signUpUser() async {
    currentUser = await auth.signInAnonymously().then((user) => user.user);
    await _fireStoreRegister();
  }

  Future<void> _fireStoreRegister() async {
    final _uid = currentUser.uid;
    await fireStore
        .collection('users')
        .document('$_uid')
        .setData(<String, dynamic>{'uid': _uid}).then(
      (_) => debugPrint('FireStore: user document set!'),
    );
  }
}
