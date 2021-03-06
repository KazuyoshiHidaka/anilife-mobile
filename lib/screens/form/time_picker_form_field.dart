import 'package:flutter/material.dart';

class TimePickerFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: const TimeOfDay(hour: 0, minute: 0).format(context),
      builder: (state) {
        return ListTile(
          onTap: () async {
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: const TimeOfDay(hour: 0, minute: 0),
            );
            if (selectedTime != null) {
              state.didChange(
                selectedTime.format(context),
              );
            }
          },
          title: const Text(
            '視聴する時刻',
          ),
          subtitle: Text(
            '${state.value}',
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 0,
          ),
        );
      },
    );
  }
}
