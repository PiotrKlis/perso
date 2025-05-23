import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StringProvider {
  StringProvider(BuildContext context) : _context = context;

  final BuildContext _context;

  AppLocalizations get strings => AppLocalizations.of(_context)!;
}
