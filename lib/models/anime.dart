class Anime {
  final int id;
  final String title;
  final List<AnimeSchedule> schedules;

  Anime(this.id, this.title, this.schedules);
}

class AnimeSchedule {
  final String broadcaster;
  final DateTime time;
  final int notifyMinutesAgo;

  AnimeSchedule(this.broadcaster, this.time, this.notifyMinutesAgo);
}
