import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DateTimePickerFormField extends StatefulWidget {
  @override
  _DateTimePickerFormFieldState createState() =>
      _DateTimePickerFormFieldState();
}

class _DateTimePickerFormFieldState extends State<DateTimePickerFormField> {
  DateTime _dateTimeState = DateTime.now();

  String _datetimeFormat(DateTime datetime) {
    var _date;
    if (datetime.year == DateTime.now().year) {
      _date = DateFormat.MMMEd("ja").format(datetime);
    } else {
      _date = DateFormat.yMMMEd("ja").format(datetime);
    }
    return "$_date  " + DateFormat.Hm("ja").format(datetime);
  }

  String _dateTimeValidator() {
    return _dateTimeState.isBefore(DateTime.now()) ? "\n現在より前の日時は指定できません" : "";
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: _datetimeFormat(_dateTimeState),
      validator: (_) {
        String _validate = _dateTimeValidator();
        if (_validate.isNotEmpty) {
          // Scaffold.of(context).showSnackBar(SnackBar(
          //   content: Text(""),
          // ));
        }
      },
      builder: (state) {
        return FlatButton(
          onPressed: () async {
            await DatePicker.showDateTimePicker(
              context,
              minTime: DateTime.now(),
              currentTime: _dateTimeState,
              locale: LocaleType.jp,
              onConfirm: (value) {
                _dateTimeState = value;
                state.didChange(_datetimeFormat(value));
              },
            );
          },
          child: ListTile(
            title: const Text(
              "視聴する日時",
            ),
            subtitle: Text(
              "${state.value}",
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
