import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

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
          home: new HomePage(title: 'My Anime'),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "",
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: "",
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
