import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/app_bar/icon_action.dart';

class PersoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PersoAppBar({
    required String title,
    super.key,
    bool isTitleCentered = false,
    List<IconAction>? iconActions,
  })  : _title = title,
        _isTitleCentered = isTitleCentered,
        _iconActions = iconActions;

  final String _title;
  final bool _isTitleCentered;
  final List<IconAction>? _iconActions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: _getActionIcon(
        iconActions: _iconActions,
        context: context,
      ),
      centerTitle: _isTitleCentered,
      elevation: 0,
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

  List<IconButton> _getActionIcon({
    required List<IconAction>? iconActions,
    required BuildContext context,
  }) {
    if (iconActions != null) {
      return iconActions.map((iconAction) {
        return IconButton(
          icon: Icon(iconAction.iconData),
          onPressed: () => iconAction.onActionIconClick.call(context),
        );
      }).toList();
    } else {
      return [];
    }
  }
}
