// import 'package:anilife_mobile/models/anime.dart';
// import 'package:flutter/material.dart';

// class MyAnimesModel extends ChangeNotifier {
//   final List<Anime> _myAnimes = [];
//   static int uniqueId = 1;

//   List<Anime> get list => _myAnimes;

//   Anime getByIndex(int index) => _myAnimes[index];
//   Anime getById(int id) => _myAnimes.reversed.firstWhere(
//         (anime) => anime.id == id,
//         orElse: () {
//           return null;
//         },
//       );

//   void add(Anime anime) {
//     _myAnimes.add(anime);
//     uniqueId++;
//     notifyListeners();
//   }

//   void remove(int id) {
//     _myAnimes.remove(getById(id));
//     notifyListeners();
//   }
// }
