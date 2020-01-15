import 'package:anilife_mobile/screens/form/anime_form.dart';
import 'package:flutter/material.dart';

class CreateAnimePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('アニメを登録'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Scaffold.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'アニメを登録しました',
                    ),
                  ),
                );
                _formKey.currentState.save();
              }
            },
            tooltip: '登録',
          ),
        ],
      ),
      body: AnimeForm(formKey: _formKey),
    );
  }
}
