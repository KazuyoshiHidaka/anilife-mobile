import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/models/my_animes.dart';
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
      contentPadding: const EdgeInsets.all(10),
      onTap: () {},
    );
  }
}

class MyAnimeOperations extends StatelessWidget {
  const MyAnimeOperations(this.anime);
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    final _myAnimesModel = Provider.of<MyAnimesModel>(context, listen: false);
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/animes/new',
              arguments: RouteArguments(anime),
            );
            print('edit id: ${anime.id}, title: ${anime.title}');
          },
        ),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            _myAnimesModel.remove(anime.id);
            print('removed id: ${anime.id}, title: ${anime.title}');
          },
        )
      ],
    );
  }
}
