import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class NotifyTimingFormField extends StatelessWidget {
  const NotifyTimingFormField();
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: 5,
      builder: (
        FormFieldState<int> state, // ignore: avoid_types_on_closure_parameters
      ) {
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
            title: const Text(
              '通知タイミング',
            ),
            subtitle: Text(
              '${state.value}分前',
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
