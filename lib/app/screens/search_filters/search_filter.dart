import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
          title: context.strings.search_filter,
        ),
        body: Center(child: Text(context.strings.search_filter_screen)));
  }
}
