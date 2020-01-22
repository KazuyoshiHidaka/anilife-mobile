import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/models/my_animes.dart';
import 'package:anilife_mobile/screens/my_animes_page/my_anime.dart';
import 'package:anilife_mobile/screens/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:provider/provider.dart';

class MyAnimes extends StatelessWidget {
  void _changeBrightness(BuildContext context) {
    Brightness _brightness;
    _brightness =
        _isBrightnessLight(context) ? Brightness.dark : Brightness.light;
    DynamicTheme.of(context).setBrightness(_brightness);
  }

  bool _isBrightnessLight(BuildContext context) {
    return DynamicTheme.of(context).brightness == Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイアニメ'),
        actions: [
          IconButton(
            icon: Icon(
              _isBrightnessLight(context)
                  ? Icons.brightness_4
                  : Icons.brightness_7,
            ),
            onPressed: () => _changeBrightness(context),
            tooltip: _isBrightnessLight(context) ? '暗いテーマにする' : '明るいテーマにする',
          ),
        ],
      ),
      body: Container(
        child: Consumer<MyAnimesModel>(
          builder: (context, myAnimes, child) => myAnimes.list.isEmpty
              ? const Center(
                  child: Text(
                    'アニメを登録できます',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MyAnime(myAnimes.getByIndex(index)),
                        MyAnimeOperations(myAnimes.getByIndex(index)),
                      ],
                    );
                  },
                  itemCount: myAnimes.list.length,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/animes/new',
            arguments: RouteArguments(
              Anime(id: MyAnimesModel.uniqueId, time: Anime.newTime),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'アニメを登録',
      ),
    );
  }
}
