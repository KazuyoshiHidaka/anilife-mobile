import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatefulWidget {
  @override
  _DatePickerFormFieldState createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  DateTime _dateState = DateTime.now().add(const Duration(days: 1));

  String _dateStateValue() {
    if (_dateState.year == DateTime.now().year) {
      return DateFormat.MMMEd('ja').format(_dateState);
    } else {
      return DateFormat.yMMMEd('ja').format(_dateState);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: _dateStateValue(),
      builder: (state) {
        return FlatButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now().subtract(const Duration(days: 1)),
              initialDate: _dateState,
              lastDate: DateTime(9999),
              locale: const Locale('ja'),
            );
            if (selectedDate != null) {
              _dateState = selectedDate;
              state.didChange(
                _dateStateValue(),
              );
            }
          },
          child: ListTile(
            title: const Text(
              '視聴する日付',
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
