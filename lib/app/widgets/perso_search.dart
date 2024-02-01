import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoSearch extends StatelessWidget {
  const PersoSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.searchHeight,
      child: TextField(
        readOnly: true,
        onChanged: (value) async {

        },
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(Dimens.searchRadius),
          ),
          fillColor: const Color(0xFFEFEFF0),
          filled: true,
          hintText: 'Search',
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(Icons.search_outlined),
        ),
      ),
    );
  }
}
