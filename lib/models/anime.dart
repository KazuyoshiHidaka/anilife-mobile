import 'package:flutter/material.dart';

class Anime {
  Anime({
    @required this.id,
    @required this.title,
    @required this.time,
    @required this.notifyMinutesAgo,
    @required this.notifyRepeatInterval,
  });
  int id, notifyMinutesAgo;
  String title, notifyRepeatInterval;
  DateTime time;
}

// class AnimeSchedule {
//   AnimeSchedule(
//     // this.broadcaster,
//     this.time,
//     this.notifyMinutesAgo,
//     this.notifyRepeatInterval,
//   );

//   // final String broadcaster;
//   final DateTime time;
//   final int notifyMinutesAgo;
//   final String notifyRepeatInterval;
// }
