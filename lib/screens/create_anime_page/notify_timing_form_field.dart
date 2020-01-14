import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class NotifyTimingFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: 5,
      builder: (state) {
        return FlatButton(
          onPressed: () {
            Picker(
              adapter: NumberPickerAdapter(data: [
                NumberPickerColumn(begin: 0, end: 60, initValue: state.value),
              ]),
              hideHeader: true,
              onConfirm: (picker, data) {
                state.didChange(data.first);
              },
            ).showDialog(context);
          },
          child: ListTile(
            title: Text(
              "通知タイミング",
            ),
            subtitle: Text(
              "${state.value}分前",
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
