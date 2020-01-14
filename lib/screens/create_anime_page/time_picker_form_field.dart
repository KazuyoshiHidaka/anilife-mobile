import 'package:flutter/material.dart';

class TimePickerFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: TimeOfDay(hour: 0, minute: 0).format(context),
      builder: (state) {
        return FlatButton(
          onPressed: () async {
            TimeOfDay selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: 0, minute: 0),
            );
            if (selectedTime != null) {
              state.didChange(
                selectedTime.format(context),
              );
            }
          },
          child: ListTile(
            title: Text(
              "時刻",
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
