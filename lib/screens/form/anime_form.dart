import 'package:anilife_mobile/models/anime_form.dart';
import 'package:flutter/material.dart';
import 'package:anilife_mobile/screens/form/datatime_picker_form_field.dart';
import 'package:anilife_mobile/screens/form/notify_repeat_interval_form_field.dart';
import 'package:anilife_mobile/screens/form/notify_timing_form_field.dart';
import 'package:anilife_mobile/screens/form/title_form_field.dart';
import 'package:provider/provider.dart';

class AnimeForm extends StatefulWidget {
  const AnimeForm({
    @required this.child,
  });
  final Widget child;

  @override
  _AnimeFormState createState() => _AnimeFormState();
}

class _AnimeFormState extends State<AnimeForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: Provider.of<AnimeFormModel>(context).formKey,
      autovalidate: true,
      child: widget.child,
      onChanged: () => print('form change ${DateTime.now()}'),
    );
  }
}

// This class is used in the CreateAnimePage class.

/// This class declare AnimeForm class's form fields:
///
/// TitleFormField, DateTimePickerFormField, NotifyTimingFormField
/// and NotifyRepeatIntervalFormField.
class AnimeFormFields extends StatelessWidget {
  const AnimeFormFields();
  static const _dividerIndent = Divider(height: 1, indent: 8);
  static const _divider = Divider(height: 1);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(
            top: 5,
            left: 8,
            right: 8,
            bottom: 20,
          ),
          child: TitleFormField(),
        ),
        _divider,
        const DateTimePickerFormField(),
        _dividerIndent,
        const NotifyTimingFormField(),
        _dividerIndent,
        NotifyRepeatIntervalFormField(),
        _divider,
      ],
    );
  }
}
