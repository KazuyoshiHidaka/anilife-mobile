import 'package:anilife_mobile/models/anime_form.dart';
import 'package:anilife_mobile/models/firebase.dart';
import 'package:anilife_mobile/screens/my_animes_page/my_animes.dart';
import 'package:anilife_mobile/screens/create_anime_page/create_anime.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AnimeFormModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => Firebase(),
        )
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
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ja'),
            ],
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
