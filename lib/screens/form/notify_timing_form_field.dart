import 'package:anilife_mobile/models/anime_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';

class NotifyTimingFormField extends StatelessWidget {
  const NotifyTimingFormField();
  @override
  Widget build(BuildContext context) {
    final _formModel = Provider.of<AnimeFormModel>(context, listen: false);
    return FormField<int>(
      initialValue: _formModel.setAnime.notifyTiming,
      onSaved: (value) {
        _formModel.setAnime.notifyTiming = value;
      },
      builder: (
        FormFieldState<int> state, // ignore: avoid_types_on_closure_parameters
      ) {
        return ListTile(
          onTap: () {
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
        );
      },
    );
  }
}
