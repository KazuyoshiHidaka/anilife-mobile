import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DateTimePickerFormField extends StatefulWidget {
  const DateTimePickerFormField();
  @override
  _DateTimePickerFormFieldState createState() =>
      _DateTimePickerFormFieldState();
}

class _DateTimePickerFormFieldState extends State<DateTimePickerFormField> {
  DateTime _dateTimeState = DateTime.now();
  String _date;

  String _datetimeFormat(DateTime datetime) {
    if (datetime.year == DateTime.now().year) {
      _date = DateFormat.MMMEd('ja').format(datetime);
    } else {
      _date = DateFormat.yMMMEd('ja').format(datetime);
    }
    return '$_date  ${DateFormat.Hm('ja').format(datetime)}';
  }

  String _errorText() {
    return _dateTimeState.isBefore(DateTime.now())
        ? '\n現在より前の日時は指定できません'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: _datetimeFormat(_dateTimeState),
      enabled: false,
      validator: (_) {
        if (_errorText() != null) {}
        return _errorText();
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
              '視聴する日時',
            ),
            subtitle: Stack(
              children: [
                Text(
                  '${state.value}',
                ),
                if (_errorText() != null)
                  Text(
                    '${_errorText()}',
                    style: TextStyle(color: Colors.red),
                  )
              ],
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
