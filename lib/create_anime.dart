import 'package:flutter/material.dart';

class CreateAnimePage extends StatelessWidget {
  final _titleFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("アニメを登録"),
      ),
      body: Form(
        autovalidate: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _titleFormController,
              maxLength: 50,
              decoration: InputDecoration(
                hintText: "タイトル",
                suffixIcon: IconButton(
                  onPressed: () {
                    _titleFormController.clear();
                  },
                  icon: Icon(Icons.clear),
                ),
              ),
              validator: (String value) {
                return value.isEmpty ? "タイトルを入力して下さい" : null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
