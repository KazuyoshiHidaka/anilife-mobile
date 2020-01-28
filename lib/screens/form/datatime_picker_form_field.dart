import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/models/anime_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class DateTimePickerFormField extends StatelessWidget {
  const DateTimePickerFormField();
  String _errorText(DateTime notifyTime) {
    if (notifyTime != null) {
      return notifyTime.isBefore(
        DateTime.now(),
      )
          ? '\n現在より前の日時に通知を送れません'
          : null;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formModel = Provider.of<AnimeFormModel>(context, listen: false);
    return FormField<DateTime>(
      initialValue: _formModel.anime.time,
      validator: (value) => _errorText(
        _formModel.notifyTime,
      ),
      builder: (state) {
        return ListTile(
          onTap: () async {
            await DatePicker.showDateTimePicker(
              context,
              minTime: DateTime.now(),
              currentTime: state.value,
              locale: LocaleType.jp,
              onConfirm: (value) {
                _formModel.setAnime.time = value;
                _formModel.updateNotifyTime();
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
              if (_errorText(_formModel.notifyTime) != null)
                Text(
                  '${_errorText(_formModel.notifyTime)}',
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
