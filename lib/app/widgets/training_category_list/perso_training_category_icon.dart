import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoTrainingCategoryIcon extends StatelessWidget {
  const PersoTrainingCategoryIcon({
    required this.path,
    required this.color,
    super.key,
  });

  final String path;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color, // Button color
        child: SizedBox(
            width: Dimens.trainingCategoryIconWidth,
            height: Dimens.trainingCategoryIconHeight,
            child: SvgPicture.asset(path, fit: BoxFit.none),),
      ),
    );
  }
}
