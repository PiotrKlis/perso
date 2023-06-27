import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(title: "Search screen"),
        body: Center(child: Text("Search screen")));
  }
}
