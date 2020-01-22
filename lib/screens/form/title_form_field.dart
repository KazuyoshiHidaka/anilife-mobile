import 'package:anilife_mobile/models/anime_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleFormField extends StatefulWidget {
  const TitleFormField();
  @override
  _TitleFormFieldState createState() => _TitleFormFieldState();
}

class _TitleFormFieldState extends State<TitleFormField> {
  TextEditingController _titleField;

  @override
  void dispose() {
    _titleField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formModel = Provider.of<AnimeFormModel>(context, listen: false);
    return TextFormField(
      controller: _titleField = TextEditingController(
        text: _formModel.anime.title,
      ),
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'タイトル',
        suffixIcon: IconButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => _titleField.clear(),
            );
          },
          icon: Icon(Icons.clear),
          tooltip: '削除',
        ),
      ),
      validator: (value) {
        return value.isEmpty ? 'タイトルを入力して下さい' : null;
      },
      onSaved: (value) {
        _formModel.setAnime.title = value;
      },
    );
  }
}
