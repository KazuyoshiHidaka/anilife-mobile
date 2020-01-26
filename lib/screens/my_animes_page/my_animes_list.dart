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
  Future<void> signIn() async {
    await _firebase.setCurrentUser();
    if (_firebase.currentUser == null) {
      await _firebase.signUpUser();
    }
  }

  @override
  void initState() {
    super.initState();
    _firebase = Provider.of<Firebase>(context, listen: false);
    signIn();
  }

  @override
  Widget build(BuildContext context) {
    // final _firebase = Provider.of<Firebase>(context, listen: true);
    return Consumer<Firebase>(
      builder: (context, firebase, child) => FutureBuilder(
        future: firebase.setMyAnimes(),
        builder: (context, snapshot) =>
            snapshot.connectionState != ConnectionState.done
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
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
