import 'package:anilife_mobile/models/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Anime {
  Anime({
    @required this.time,
    this.title = '',
    this.notifyTiming = 5,
    this.notifyRepeatIntervalNum = 0,
    this.id,
  });
  static DateTime newTime = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().add(const Duration(days: 1)).day,
  ).toLocal();
  static const notifyRepeatIntervalList = ['繰り返さない', '毎週', '毎日'];

  int notifyTiming, notifyRepeatIntervalNum;
  String title, id;
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

  static Anime
      convertFireStoreMapToAnimeType // ignore: prefer_constructors_over_static_methods
      (
    Map<String, dynamic> data,
    String animeId,
  ) {
    final _timeStamp = data['time'] as Timestamp;
    final _time = _timeStamp.toDate();
    final _title = data['title'] as String;
    final _notifyRepeatIntervalDayCount =
        data['notifyRepeatIntervalDayCount'] as int;
    final _notifyRepeatIntervalNum = Firebase.notifyRepeatIntervalDayCounts
        .indexOf(_notifyRepeatIntervalDayCount);
    final _notifyTiming = data['notifyTiming'] as int;
    return Anime(
      time: _time,
      title: _title,
      notifyRepeatIntervalNum: _notifyRepeatIntervalNum,
      notifyTiming: _notifyTiming,
      id: animeId,
    );
  }
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
