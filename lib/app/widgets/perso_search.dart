import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PersoSearch extends StatelessWidget {
  const PersoSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.searchHeight,
      child: TextField(
        readOnly: true,
        onChanged: (value) =>
            context.pushNamed(ScreenNavigationKey.searchResults),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(Dimens.searchRadius),),
            fillColor: const Color(0xFFEFEFF0),
            filled: true,
            hintText: 'Search',
            contentPadding: EdgeInsets.zero,
            prefixIcon: const Icon(Icons.search_outlined),),
      ),
    );
  }
}
