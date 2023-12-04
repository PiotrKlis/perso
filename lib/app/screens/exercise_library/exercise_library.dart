import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/exercise_list/exercise_list_widget.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_search.dart';

class ExerciseLibraryScreen extends StatelessWidget {
  const ExerciseLibraryScreen({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersoAppBar(
        title: 'Exercise library',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: Dimens.xmMargin,
                right: Dimens.xmMargin,
              ),
              child: const PersoSearch(),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.xmMargin),
              color: PersoColors.lightBlue,
              child: const ExercisesList(),
            ),
          ],
        ),
      ),
    );
  }
}
