import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class NotifyRepeatIntervalFormField extends StatelessWidget {
  static const _repeatIntervals = ["繰り返さない", "毎週", "毎日"];
  static const _data = '''[["繰り返さない", "毎週", "毎日"]]''';
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: "繰り返さない",
      builder: (state) {
        return FlatButton(
          onPressed: () {
            Picker(
                adapter: PickerDataAdapter<String>(
                    pickerdata: new JsonDecoder().convert(_data),
                    isArray: true),
                hideHeader: true,
                confirmText: "選択",
                cancelText: "キャンセル",
                onConfirm: (Picker picker, List data) {
                  state.didChange(_repeatIntervals[data.first]);
                }).showDialog(context);
          },
          child: ListTile(
            title: Text(
              "繰り返し",
            ),
            subtitle: Text(
              "${state.value}",
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 0,
            ),
          ),
          padding: EdgeInsets.all(0),
        );
      },
    );
  }
}
