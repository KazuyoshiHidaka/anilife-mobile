import 'dart:async';

import 'package:anilife_mobile/models/anime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Firebase extends ChangeNotifier {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final Firestore fireStore = Firestore.instance;
  final FirebaseMessaging messaging = FirebaseMessaging();
  FirebaseUser currentUser;
  String _uid;
  Stream<QuerySnapshot> myAnimes;

  static const notifyRepeatIntervalDayCounts = [
    0, // 繰り返さない
    7, // 毎週
    1, // 毎日
  ];

  Future<void> signUpUser() async {
    print('user signin!');
    currentUser = await auth
        .signInAnonymously()
        .then((user) => user.user);
    _uid ??= currentUser.uid;
    setMyAnimes();
    notifyListeners();
  }

  Future<void> setAnime(Anime anime) async {
    final _animesCollection =
        fireStore.collection('users').document(_uid).collection('animes');
    final _animeDocument = anime.id == null
        ? _animesCollection.document()
        : _animesCollection.document(anime.id);
    await _animeDocument.setData(<String, dynamic>{
      'time': anime.time,
      'title': anime.title,
      'notifyTiming': anime.notifyTiming,
      'notifyRepeatIntervalDayCount':
          notifyRepeatIntervalDayCounts[anime.notifyRepeatIntervalNum],
      'notifyTime': anime.time.subtract(
        Duration(minutes: anime.notifyTiming),
      ),
    });
    await messaging.subscribeToTopic('/topics/${currentUser.uid}');
    await messaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
  }

  Future<void> removeAnime(Anime anime) async {
    await fireStore
        .collection('users')
        .document(_uid)
        .collection('animes')
        .document(anime.id)
        .delete();
  }

  void setMyAnimes() {
    myAnimes = fireStore
          .collection('users')
          .document(_uid)
          .collection('animes')
          .orderBy('time')
          .snapshots();
  }
}
