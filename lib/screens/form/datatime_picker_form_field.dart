import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/models/anime_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class DateTimePickerFormField extends StatelessWidget {
  const DateTimePickerFormField();
  String _errorText(DateTime dateTime) {
    return dateTime.isBefore(DateTime.now()) ? '\n現在より前の日時は指定できません' : null;
  }

  @override
  Widget build(BuildContext context) {
    final _formModel = Provider.of<AnimeFormModel>(context, listen: false);
    return FormField<DateTime>(
      initialValue: _formModel.anime.time,
      validator: _errorText,
      onSaved: (value) {
        _formModel.setAnime.time = value;
      },
      builder: (state) {
        return ListTile(
          onTap: () async {
            await DatePicker.showDateTimePicker(
              context,
              minTime: DateTime.now(),
              currentTime: state.value,
              locale: LocaleType.jp,
              onConfirm: (value) {
                state.didChange(
                  value,
                );
              },
            );
          },
          title: const Text(
            '視聴する日時',
          ),
          subtitle: Stack(
            children: [
              Text(
                '${Anime.dateFormat(state.value)}',
              ),
              if (_errorText(state.value) != null)
                Text(
                  '${_errorText(state.value)}',
                  style: TextStyle(color: Colors.red),
                )
            ],
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
