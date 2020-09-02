// WIP

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class LoopRecordLocalizations {
  LoopRecordLocalizations(this.locale);
  final Locale locale;

  static LoopRecordLocalizations of(BuildContext context) {
    return Localizations.of<LoopRecordLocalizations>(
        context, LoopRecordLocalizations);
  }
}
