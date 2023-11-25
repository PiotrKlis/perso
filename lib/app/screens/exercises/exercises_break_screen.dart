import 'package:flutter/material.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';

class ExercisesBreakScreen extends StatelessWidget {
  const ExercisesBreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersoAppBar(title: 'break',),
    );
  }
}
