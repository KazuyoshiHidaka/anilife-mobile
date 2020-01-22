import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Anime {
  Anime({
    @required this.id,
    @required this.time,
    this.title = '',
    this.notifyTiming = 5,
    this.notifyRepeatIntervalNum = 0,
  });
  static DateTime newTime = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().add(const Duration(days: 1)).day,
  ).toLocal();
  static const notifyRepeatIntervalList = ['繰り返さない', '毎週', '毎日'];

  int notifyTiming, notifyRepeatIntervalNum, id;
  String title;
  DateTime time;

  static String dateFormat(DateTime dateTime) {
    final fmt = dateTime.year == DateTime.now().year
        ? DateFormat.MMMEd('ja')
        : DateFormat.yMMMEd('ja');
    return fmt.add_Hm().format(dateTime);
  }

  String get dateTime => dateFormat(time);
  String get notifyRepeatInterval =>
      notifyRepeatIntervalList[notifyRepeatIntervalNum];
}

// class AnimeSchedule {
//   AnimeSchedule(
//     // this.broadcaster,
//     this.time,
//     this.notifyTiming,
//     this.notifyRepeatInterval,
//   );

//   // final String broadcaster;
//   final DateTime time;
//   final int notifyTiming;
//   final String notifyRepeatInterval;
// }
