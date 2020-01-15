import 'package:flutter/material.dart';
import 'package:anilife_mobile/screens/form/datatime_picker_form_field.dart';
import 'package:anilife_mobile/screens/form/date_picker_form_field.dart';
import 'package:anilife_mobile/screens/form/notify_repeat_interval_form_field.dart';
import 'package:anilife_mobile/screens/form/notify_timing_form_field.dart';
import 'package:anilife_mobile/screens/form/time_picker_form_field.dart';
import 'package:anilife_mobile/screens/form/title_form_field.dart';

class AnimeForm extends StatefulWidget {
  const AnimeForm({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);
  final GlobalKey<FormState> _formKey;

  @override
  _AnimeFormState createState() => _AnimeFormState();
}

class _AnimeFormState extends State<AnimeForm> {
  static const _dividerIndent = Divider(height: 1, indent: 8);
  static const _divider = Divider(height: 1);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      autovalidate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 8,
              right: 8,
              bottom: 20,
            ),
            child: TitleFormField(),
          ),
          _divider,
          // DatePickerFormField(),
          // _dividerIndent,
          // TimePickerFormField(),
          DateTimePickerFormField(),
          _dividerIndent,
          NotifyTimingFormField(),
          _dividerIndent,
          NotifyRepeatIntervalFormField(),
          _divider,
        ],
      ),
    );
  }
}
