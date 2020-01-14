import 'package:flutter/material.dart';

class TitleFormField extends StatefulWidget {
  @override
  _TitleFormFieldState createState() => _TitleFormFieldState();
}

class _TitleFormFieldState extends State<TitleFormField> {
  final _titleField = TextEditingController();

  void dispose() {
    _titleField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _titleField,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: "タイトル",
        suffixIcon: IconButton(
          onPressed: () {
            /// [flutter bug]
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => _titleField.clear(),
            );
          },
          icon: Icon(Icons.clear),
          tooltip: "削除",
        ),
      ),
      validator: (String value) {
        return value.isEmpty ? "タイトルを入力して下さい" : null;
      },
    );
  }
}
