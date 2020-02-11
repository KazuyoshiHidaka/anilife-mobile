flutter packages pub run intl_translation:extract_to_arb \
    --locale=messages \
    --output-dir=lib/l10n/src \
    lib/l10n/messages.dart

cat lib/l10n/src/intl_messages.arb | \
    sed -e 's/"@@locale": "messages"/"@@locale": "ja"/g' > \
    lib/l10n/src/intl_ja.arb

echo lib/l10n/src/intl_en.arbを編集して、英語の翻訳に直してください