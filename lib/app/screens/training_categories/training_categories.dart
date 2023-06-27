import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:flutter/material.dart';

class TrainingCategoriesScreen extends StatelessWidget {
  const TrainingCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(title: "Training categories"),
        body: Center(child: Text("Training categories screen")));
  }
}
