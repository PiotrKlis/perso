import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PersoAppBar(
      {super.key,
      IconData? actionIcon,
      bool isTitleCentered = false,
      required String title,
      void Function(BuildContext context)? onActionIconClick})
      : _title = title,
        _isTitleCentered = isTitleCentered,
        _onActionIconClick = onActionIconClick,
        _actionIcon = actionIcon;

  final String _title;
  final bool _isTitleCentered;
  final IconData? _actionIcon;
  final void Function(BuildContext context)? _onActionIconClick;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: _getActionIcon(
          actionIcon: _actionIcon,
          onActionIconClick: _onActionIconClick,
          context: context),
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

  List<IconButton> _getActionIcon(
      {required IconData? actionIcon,
      required Function(BuildContext context)? onActionIconClick,
      required BuildContext context}) {
    if (actionIcon != null) {
      return [
        IconButton(
            icon: Icon(actionIcon),
            onPressed: () => onActionIconClick?.call(context)),
      ];
    } else {
      return [];
    }
  }
}
