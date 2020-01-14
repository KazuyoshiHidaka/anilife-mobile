import 'package:anilife_mobile/screens/create_anime_page/date_picker_form_field.dart';
import 'package:anilife_mobile/screens/create_anime_page/notify_timing_form_field.dart';
import 'package:anilife_mobile/screens/create_anime_page/time_picker_form_field.dart';
import 'package:anilife_mobile/screens/create_anime_page/title_form_field.dart';
import 'package:flutter/material.dart';

class CreateAnimePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                    content: Text(
                      "アニメを登録しました",
                    ),
                  ),
                );
                _formKey.currentState.save();
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
            Padding(
              padding: EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 20,
              ),
              child: TitleFormField(),
            ),
            DatePickerFormField(),
            Divider(
              height: 1,
              indent: 8,
            ),
            TimePickerFormField(),
            Divider(
              height: 1,
              indent: 8,
            ),
            NotifyTimingFormField(),
          ],
        ),
      ),
    );
  }
}
