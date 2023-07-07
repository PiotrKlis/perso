import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PersoAppBar({
    super.key,
    bool isTitleCentered = false,
    required String title,
  })  : _title = title,
        _isTitleCentered = isTitleCentered;

  final String _title;
  final bool _isTitleCentered;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () => context.pushNamed(ScreenNavigationKey.filters),
        ),
      ],
      centerTitle: _isTitleCentered,
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
