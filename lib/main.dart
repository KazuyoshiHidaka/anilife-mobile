import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'my_anime.dart';
import 'create_anime.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'AniLife',
          theme: theme,
          initialRoute: '/',
          routes: {
            '/': (context) => MyAnime(title: "マイアニメ"),
            '/animes/new': (context) => CreateAnimePage(),
          },
        );
      },
    );
  }
}
