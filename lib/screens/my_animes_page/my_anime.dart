import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/models/firebase.dart';
import 'package:anilife_mobile/screens/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAnime extends StatelessWidget {
  const MyAnime(this.anime);
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        anime.title,
        style: const TextStyle(fontSize: 19),
      ),
      subtitle: Text(
        '${anime.dateTime}\n通知タイミング: ${anime.notifyTiming}分前\n'
        '通知繰り返し: ${anime.notifyRepeatInterval}',
      ),
      isThreeLine: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      onTap: () {},
    );
  }
}

class MyAnimeOperations extends StatelessWidget {
  const MyAnimeOperations(this.anime);
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<Firebase>(context, listen: false);
    return Row(
      children: <Widget>[
        IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(Icons.edit),
          tooltip: '編集',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/animes/new',
              arguments: RouteArguments(anime),
            );
            print('edit title: ${anime.title}');
          },
        ),
        IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(Icons.clear),
          tooltip: '削除',
          onPressed: () {
            _firebase.removeAnime(anime);
            print('removed title: ${anime.title}');
          },
        )
      ],
    );
  }
}
