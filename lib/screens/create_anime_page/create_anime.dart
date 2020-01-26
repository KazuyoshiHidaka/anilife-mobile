import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/models/anime_form.dart';
import 'package:anilife_mobile/models/firebase.dart';
import 'package:anilife_mobile/models/my_animes.dart';
import 'package:anilife_mobile/screens/form/anime_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAnimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firebase = Provider.of<Firebase>(context, listen: true);
    final _formModel = Provider.of<AnimeFormModel>(context, listen: true);
    final _formKey = _formModel.formKey;
    final dynamic _routeArguments = ModalRoute.of(context).settings.arguments;
    _formModel.setAnime = _routeArguments?.anime as Anime;
    return Scaffold(
      appBar: AppBar(
        title: const Text('アニメを登録'),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.check),
                tooltip: '登録',
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Scaffold.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          '保存しています...',
                        ),
                      ),
                    );
                    await _firebase.setAnime(_formModel.setAnime);
                    Navigator.pop(context);
                  }
                },
              );
            },
          )
        ],
      ),
      body: const AnimeForm(
        child: AnimeFormFields(),
      ),
    );
  }
}
