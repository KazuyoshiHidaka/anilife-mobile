import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Anime {
  Anime({
    @required this.id,
    @required this.title,
    @required this.time,
    this.notifyMinutesAgo = 5,
    this.notifyRepeatInterval = '繰り返さない',
  });
  int id, notifyMinutesAgo;
  String title, notifyRepeatInterval;
  DateTime time;

  static String dateFormat(DateTime dateTime) {
    final fmt = dateTime.year == DateTime.now().year
        ? DateFormat.MMMEd('ja')
        : DateFormat.yMMMEd('ja');
    return fmt.add_Hm().format(dateTime);
  }

  String get dateTime => dateFormat(time);
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
