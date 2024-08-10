library app_localizations;

// export 'package:flutter_gen/gen_l10n/localizations_ext.dart';

// library app_localizations;

import 'package:flutter/material.dart';
import 'package:kunai/kunai.dart';


extension BasicL10nExt on BuildContext {
  KunaiLocalizations get kunaiL10n => KunaiLocalizations.of(this);
}

extension BasicStateL10nExt on State {
  KunaiLocalizations get kunaiL10n => context.kunaiL10n;
}
