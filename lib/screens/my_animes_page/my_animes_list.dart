import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/models/firebase.dart';
import 'package:anilife_mobile/screens/my_animes_page/my_anime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAnimesList extends StatefulWidget {
  @override
  _MyAnimesListState createState() => _MyAnimesListState();
}

class _MyAnimesListState extends State<MyAnimesList> {
  Firebase _firebase;

  void _buildDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text('$message'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _firebase = Provider.of<Firebase>(context, listen: false);
    _firebase.messaging.configure(
      onMessage: (message) async {
        print('onMessage: $message');
        final dynamic _title = message['notification']['title'];
        final dynamic _body = message['notification']['body'];
        _buildDialog(
          context,
          '$_title\n$_body',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Firebase>(
      builder: (context, firebase, child) => FutureBuilder(
        future: firebase.signUpUser(),
        builder: (context, snapshot) =>
            snapshot.connectionState != ConnectionState.done
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const CircularProgressIndicator(
                        strokeWidth: 6,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(firebase.loadingText),
                    ],
                  ))
                : firebase.myAnimes.isEmpty
                    ? const Center(
                        child: Text(
                          'アニメを登録できます',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final _anime = Anime.convertFireStoreMapToAnimeType(
                              firebase.myAnimes[index].data,
                              firebase.myAnimes[index].documentID);
                          return Column(
                            children: [
                              MyAnime(_anime),
                              MyAnimeOperations(_anime),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        },
                        itemCount: firebase.myAnimes.length,
                      ),
      ),
    );
  }
}
