import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/screens/my_animes_page/my_animes_list.dart';
import 'package:anilife_mobile/screens/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

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
        child: MyAnimesList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/animes/new',
            arguments: RouteArguments(
              Anime(time: Anime.newTime),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'アニメを登録',
      ),
    );
  }
}
