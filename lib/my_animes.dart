import 'package:anilife_mobile/models/my_animes.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:provider/provider.dart';

class MyAnimes extends StatelessWidget {
  void _changeBrightness(context) {
    _isBrightnessLight(context)
        ? DynamicTheme.of(context).setBrightness(Brightness.dark)
        : DynamicTheme.of(context).setBrightness(Brightness.light);
  }

  bool _isBrightnessLight(context) {
    return DynamicTheme.of(context).brightness == Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("マイアニメ"),
        actions: [
          IconButton(
            icon: Icon(
              _isBrightnessLight(context)
                  ? Icons.brightness_4
                  : Icons.brightness_7,
            ),
            onPressed: () => _changeBrightness(context),
            tooltip: _isBrightnessLight(context) ? "暗いテーマにする" : "明るいテーマにする",
          ),
        ],
      ),
      body: Consumer<MyAnimesModel>(
        builder: (context, myAnimes, child) => Text(""),
      ),
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