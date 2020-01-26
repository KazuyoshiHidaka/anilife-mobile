import 'package:anilife_mobile/models/anime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Firebase extends ChangeNotifier {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final Firestore fireStore = Firestore.instance;
  FirebaseUser currentUser;
  String _uid;
  List<DocumentSnapshot> myAnimes;
  bool _updateMyAnimes;

  Future<void> setCurrentUser() async {
    currentUser = await auth.currentUser();
    _uid = currentUser.uid;
  }

  Future<void> signUpUser() async {
    currentUser = await auth.signInAnonymously().then((user) => user.user);
    await _fireStoreRegister();
  }

  Future<void> _fireStoreRegister() async {
    await fireStore
        .collection('users')
        .document(_uid)
        .setData(<String, dynamic>{'uid': _uid}).then(
      (_) => debugPrint('FireStore: user document set!'),
    );
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
      'notifyRepeatIntervalNum': anime.notifyRepeatIntervalNum
    }).then((_) =>
        debugPrint('FireStore: anime document set!  title: ${anime.title}'));
    _updateMyAnimes = true;
    notifyListeners();
  }

  Future<void> removeAnime(Anime anime) async {
    await fireStore
        .collection('users')
        .document(_uid)
        .collection('animes')
        .document(anime.id)
        .delete()
        .then((_) => debugPrint(
            'FireStore: anime document delete!  title: ${anime.title}'));
    _updateMyAnimes = true;
    notifyListeners();
  }

  Future<void> setMyAnimes() async {
    if (myAnimes == null || _updateMyAnimes == true) {
      myAnimes = await fireStore
          .collection('users')
          .document(_uid)
          .collection('animes')
          .getDocuments()
          .then((querySnapShot) => querySnapShot.documents);
      _updateMyAnimes = false;
      debugPrint('FireStore: Set MyAnimes! length: ${myAnimes.length}');
    }
  }
}
