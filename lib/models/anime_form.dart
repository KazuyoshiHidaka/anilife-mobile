import 'package:anilife_mobile/models/anime.dart';
import 'package:flutter/material.dart';

class AnimeFormModel {
  Anime anime;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime notifyTime;

  Anime get setAnime => anime;
  set setAnime(Anime anime) => this.anime = anime;

  void updateNotifyTime() {
    notifyTime = anime.time.subtract(
      Duration(minutes: anime.notifyTiming),
    );
  }
}
