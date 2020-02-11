flutter packages pub run intl_translation:generate_from_arb \
    --output-dir=lib/l10n/src \
    --no-use-deferred-loading \
    lib/l10n/messages.dart \
    lib/l10n/src/intl_*.arb