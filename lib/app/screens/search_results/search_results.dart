import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key, String? input = ""}) : _input = input;
  final String? _input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: const PersoAppBar(title: "Search results", shouldShowFilterIcon: true,),
        body: Center(child: Text("Search results screen, input: $_input")));
  }
}
