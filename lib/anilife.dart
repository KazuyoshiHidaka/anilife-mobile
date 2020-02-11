import 'package:anilife_mobile/l10n/src/l10n.dart';
import 'package:anilife_mobile/models/animes_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AniLife extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AnimesListModel>(
          create: (_) => AnimesListModel(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          L10n.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ja'),
          const Locale('en'), // English
          // ... other locales the app supports
        ],
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${L10n.of(context).anime}')),
    );
  }
}
