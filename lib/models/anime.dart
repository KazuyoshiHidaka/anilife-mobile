class Anime {
  Anime(this.id, this.title, this.schedules);

  final int id;
  final String title;
  final List<AnimeSchedule> schedules;
}

class AnimeSchedule {
  AnimeSchedule(this.broadcaster, this.time, this.notifyMinutesAgo);

  final String broadcaster;
  final DateTime time;
  final int notifyMinutesAgo;
}
