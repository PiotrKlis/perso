import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryWidget extends StatelessWidget {
  final SvgPicture picture;
  final Text text;

  const CategoryWidget({super.key, required this.picture, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [picture, text],
    );
  }
}