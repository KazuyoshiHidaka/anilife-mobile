import 'package:anilife_mobile/screens/form/anime_form.dart';
import 'package:flutter/material.dart';

class CreateAnimePage extends StatelessWidget {
  CreateAnimePage({@required Text title}) : _title = title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Text _title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title,
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.check),
                tooltip: '登録',
                onPressed: () {
                  final _form = _formKey.currentState;
                  if (_form.validate()) {
                    Scaffold.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'アニメを登録しました',
                        ),
                      ),
                    );
                    _form.save();
                  }
                },
              );
            },
          )
        ],
      ),
      body: AnimeForm(
        formKey: _formKey,
        child: const AnimeFormFields(),
      ),
    );
  }
}
