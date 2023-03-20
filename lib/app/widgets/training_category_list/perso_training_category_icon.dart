import 'package:Perso/app/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersoTrainingCategoryIcon extends StatelessWidget {
  final String path;
  final Color color;

  const PersoTrainingCategoryIcon({super.key, required this.path, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color, // Button color
        child: SizedBox(
            width: Dimens.trainingCategoryIconWidth,
            height: Dimens.trainingCategoryIconHeight,
            child: SvgPicture.asset(path, fit: BoxFit.none)),
      ),
    );
  }
}
