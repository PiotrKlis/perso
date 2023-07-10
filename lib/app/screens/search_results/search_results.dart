import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key, String? input = ""}) : _input = input;
  final String? _input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
          title: "Search results",
          actionIcon: Icons.filter_list,
          onActionIconClick: onActionClick,
        ),
        body: Center(child: Text("Search results screen, input: $_input")));
  }

  void onActionClick(BuildContext context) {
    context.pushNamed(ScreenNavigationKey.searchFilter,
        pathParameters: {"input": _input ?? ""});
  }
}
