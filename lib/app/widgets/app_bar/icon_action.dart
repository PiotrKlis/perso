import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_action.freezed.dart';

@freezed
class IconAction with _$IconAction {
  const factory IconAction({
    required IconData iconData,
    required void Function(BuildContext context) onActionIconClick,
  }) = _IconAction;
}
