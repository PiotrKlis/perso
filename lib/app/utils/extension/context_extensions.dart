import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsExtensions on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;

  void showSuccessfulSnackBar(String text) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(text), backgroundColor: Colors.green),
      );
  }

  void showFailedSnackBar(String text) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(text), backgroundColor: Colors.red),
      );
  }

  //GoRouter extension
  void clearAndNavigate(String path) {
    while (canPop() == true) {
      pop();
    }
    pushNamed(path);
  }
}
