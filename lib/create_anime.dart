import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAnimePage extends StatefulWidget {
  @override
  _CreateAnimePageState createState() => _CreateAnimePageState();
}

class _CreateAnimePageState extends State<CreateAnimePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _titleField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("アニメを登録"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text("Process Data"),
                  ),
                );
              }
            },
            tooltip: "登録",
          ),
        ],
      ),
      body: Container(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _titleField,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: "タイトル",
                  suffixIcon: IconButton(
                    onPressed: () {
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
              ),
              FormField(
                initialValue: "${DateFormat.Md('ar').format(DateTime.now())}",
                builder: (state) {
                  return FlatButton(
                    onPressed: () async {
                      DateTime selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now().subtract(Duration(days: 1)),
                        initialDate: DateTime.now(),
                        lastDate: DateTime(9999),
                        locale: Locale("ja"),
                      );
                      if (selectedDate != null) {
                        state.didChange(
                          "${DateFormat.Md().format(selectedDate)}",
                        );
                      }
                    },
                    child: ListTile(
                      title: Text("視聴する日時"),
                      subtitle: Text("${state.value}"),
                      contentPadding: EdgeInsets.all(0),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
