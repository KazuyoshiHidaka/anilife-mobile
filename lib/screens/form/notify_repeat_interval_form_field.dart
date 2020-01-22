import 'dart:convert';

import 'package:anilife_mobile/models/anime.dart';
import 'package:anilife_mobile/models/anime_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';

class NotifyRepeatIntervalFormField extends StatelessWidget {
  static const _data = '''[["繰り返さない", "毎週", "毎日"]]''';
  static final _pickerdata = const JsonDecoder().convert(_data) as List;
  @override
  Widget build(BuildContext context) {
    final _formModel = Provider.of<AnimeFormModel>(context, listen: false);
    return FormField<int>(
      initialValue: _formModel.setAnime.notifyRepeatIntervalNum,
      onSaved: (value) {
        _formModel.setAnime.notifyRepeatIntervalNum = value;
      },
      builder: (state) {
        return ListTile(
          title: const Text(
            '繰り返し',
          ),
          subtitle: Text(
            '${Anime.notifyRepeatIntervalList[state.value]}',
          ),
          onTap: () {
            Picker(
              adapter: PickerDataAdapter<String>(
                pickerdata: _pickerdata,
                isArray: true,
              ),
              hideHeader: true,
              confirmText: '選択',
              cancelText: 'キャンセル',
              selecteds: [state.value],
              onConfirm: (picker, data) {
                state.didChange(data.first);
              },
            ).showDialog(context);
          },
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 0,
          ),
        );
      },
    );
  }
}
