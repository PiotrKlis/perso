import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/widgets/perso_app_bar.dart';
import 'package:flutter/material.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(
          title: "Search filter",
        ),
        body: Center(child: Text("Search filter screen")));
  }
}
