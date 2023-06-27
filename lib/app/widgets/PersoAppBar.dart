import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PersoAppBar({
    super.key,
    required String title,
  }) : _title = title;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: PersoColors.lightWhite,
      title: Text(
        _title,
        style: ThemeText.bodyBoldBlackText,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
