import 'package:intl/intl.dart';

/// updateの方法
/// 1. Intl.message()を追加
/// 2. bash lib/l10n/update_l10n_before.sh
/// 3. lib/l10n/src/intl_en.arbを編集して、英語版に対応
/// 4. bash lib/l10n/update_l10n_after.sh

mixin Messages {
  String get hello => Intl.message(
        'こんにちは',
        name: 'hello',
        desc: '挨拶', // オプション
      );

  String get anime => Intl.message(
        'アニメ',
        name: 'anime',
      );
}
