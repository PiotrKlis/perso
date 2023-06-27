import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersoSearch extends StatelessWidget {
  const PersoSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.searchHeight,
      child: TextField(
        readOnly: true,
        onChanged: (value) =>
            context.pushNamed(ScreenNavigationKey.searchResults),
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(Dimens.searchRadius)),
            fillColor: const Color(0xFFEFEFF0),
            filled: true,
            hintText: "Search",
            contentPadding: EdgeInsets.zero,
            prefixIcon: const Icon(Icons.search_outlined)),
      ),
    );
  }
}
