import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class NotifyRepeatIntervalFormField extends StatelessWidget {
  const NotifyRepeatIntervalFormField();
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: '繰り返さない',
      builder: (state) {
        return PickerFlatButton(
          state,
          child: ListTile(
            title: const Text(
              '繰り返し',
            ),
            subtitle: Text(
              '${state.value}',
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 0,
            ),
          ),
          padding: const EdgeInsets.all(0),
        );
      },
    );
  }
}

class PickerFlatButton extends StatelessWidget {
  PickerFlatButton(this.state, {@required this.child, @required this.padding});
  final FormFieldState<dynamic> state;
  final ListTile child;
  final EdgeInsets padding;
  static const _repeatIntervals = ['繰り返さない', '毎週', '毎日'];
  static const _data = '''[["繰り返さない", "毎週", "毎日"]]''';
  final _pickerdata = const JsonDecoder().convert(_data) as List;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Picker(
          adapter: PickerDataAdapter<String>(
            pickerdata: _pickerdata,
            isArray: true,
          ),
          hideHeader: true,
          confirmText: '選択',
          cancelText: 'キャンセル',
          onConfirm: (picker, data) {
            state.didChange(_repeatIntervals[data.first]);
          },
        ).showDialog(context);
      },
      child: child,
      padding: padding,
    );
  }
}
