import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/models/firebase.dart';
import 'package:anilife_mobile/screens/my_animes_page/my_anime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    _firebase = Provider.of<Firebase>(context, listen: false)..signUpUser();
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
    return StreamBuilder(
      stream: Provider.of<Firebase>(context, listen: true).myAnimes,
      builder: (
        context,
        AsyncSnapshot< // ignore: avoid_types_on_closure_parameters
                QuerySnapshot>
            snapshot,
      ) {
        if (!snapshot.hasData) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              CircularProgressIndicator(
                strokeWidth: 6,
              ),
              SizedBox(
                height: 10,
              ),
              Text('セットアップ中...'),
            ],
          ));
        } else {
          return snapshot.data.documents.isEmpty
              ? const Center(
                  child: Text(
                    'アニメを登録できます',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final _anime = Anime.convertFireStoreMapToAnimeType(
                        snapshot.data.documents[index].data,
                        snapshot.data.documents[index].documentID);
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
                  itemCount: snapshot.data.documents.length,
                );
        }
      },
    );
  }
}
