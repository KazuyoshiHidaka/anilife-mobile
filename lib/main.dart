import 'package:anilife_mobile/models/my_animes.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:provider/provider.dart';

import 'my_animes.dart';
import 'create_anime.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyAnimesModel(),
        ),
      ],
      child: DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blue,
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: 'AniLife',
            theme: theme,
            initialRoute: '/',
            routes: {
              '/': (context) => MyAnimes(),
              '/animes/new': (context) => CreateAnimePage(),
            },
          );
        },
      ),
    );
  }
}
