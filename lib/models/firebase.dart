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
  List<DocumentSnapshot> myAnimes;
  bool _updateMyAnimes;
  String loadingText = 'セットアップ中...';

  static const notifyRepeatIntervalDayCounts = [
    0, // 繰り返さない
    7, // 毎週
    1, // 毎日
  ];

  Future<void> signUpUser() async {
    currentUser ??= await auth.currentUser();
    if (currentUser == null) {
      currentUser = await auth.signInAnonymously().then((user) => user.user);
      await messaging.subscribeToTopic('/topics/all');
      await messaging.subscribeToTopic('/topics/${currentUser.uid}');
      print('init currentUser!');
    }
    _uid ??= currentUser.uid;
    await setMyAnimes();
    loadingText = 'セットアップ中...';
  }

  Future<void> setAnime(Anime anime) async {
    loadingText = '更新中...';
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
    await messaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    _updateMyAnimes = true;
    notifyListeners();
  }

  Future<void> removeAnime(Anime anime) async {
    loadingText = '削除中...';
    await fireStore
        .collection('users')
        .document(_uid)
        .collection('animes')
        .document(anime.id)
        .delete();
    _updateMyAnimes = true;
    notifyListeners();
  }

  Future<void> setMyAnimes() async {
    if (myAnimes == null || _updateMyAnimes == true) {
      myAnimes = await fireStore
          .collection('users')
          .document(_uid)
          .collection('animes')
          .orderBy('time')
          .getDocuments()
          .then((querySnapShot) => querySnapShot.documents);
      _updateMyAnimes = false;
    }
  }
}
