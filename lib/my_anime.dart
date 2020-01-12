import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class MyAnime extends StatefulWidget {
  MyAnime({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyAnimeState createState() => _MyAnimeState();
}

class _MyAnimeState extends State<MyAnime> {
  void _changeBrightness() {
    _isBrightnessLight()
        ? DynamicTheme.of(context).setBrightness(Brightness.dark)
        : DynamicTheme.of(context).setBrightness(Brightness.light);
  }

  bool _isBrightnessLight() {
    return DynamicTheme.of(context).brightness == Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              _isBrightnessLight() ? Icons.brightness_4 : Icons.brightness_7,
            ),
            onPressed: () => _changeBrightness(),
            tooltip: _isBrightnessLight() ? "Dark Theme" : "Light Theme",
          ),
        ],
      ),
      // body: ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/animes/new',
          );
        },
        child: Icon(Icons.add),
        tooltip: "アニメを登録",
      ),
    );
  }
}
