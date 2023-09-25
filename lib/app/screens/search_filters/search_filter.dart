import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
          title: AppLocalizations.of(context)!.search_filter,
        ),
        body: Center(child: Text(AppLocalizations.of(context)!.search_filter_screen)));
  }
}
