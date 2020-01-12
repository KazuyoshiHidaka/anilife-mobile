import 'package:anilife_mobile/models/anime.dart';
import 'package:flutter/material.dart';

class MyAnimesModel extends ChangeNotifier {
  final List<Anime> _myAnimes = [];

  Anime getById(int id) => _myAnimes.firstWhere((anime) => anime.id == id);
  List<Anime> get animes => _myAnimes;

  void add(Anime anime) {
    _myAnimes.add(anime);
    notifyListeners();
  }
}
