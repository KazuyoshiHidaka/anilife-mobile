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
  DateTime _dateState = DateTime.now();

  String _dateStateValue() {
    if (_dateState.year == DateTime.now().year) {
      return DateFormat.MMMEd("ja").format(_dateState);
    } else {
      return DateFormat.yMMMEd("ja").format(_dateState);
    }
  }

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
      body: Form(
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
            ),
            SizedBox(
              height: 20,
            ),
            FormField(
              initialValue: _dateStateValue(),
              builder: (state) {
                return FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () async {
                    DateTime selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 1)),
                      initialDate: _dateState,
                      lastDate: DateTime(9999),
                      locale: Locale("ja"),
                    );
                    if (selectedDate != null) {
                      _dateState = selectedDate;
                      state.didChange(
                        _dateStateValue(),
                      );
                    }
                  },
                  child: ListTile(
                    title: Text(
                      "視聴する日付",
                    ),
                    subtitle: Text(
                      "${state.value}",
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                  ),
                );
              },
            ),
            Divider(
              height: 1,
              indent: 10,
            )
          ],
        ),
      ),
    );
  }
}
