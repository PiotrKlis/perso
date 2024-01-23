import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';

//TODO: Divide into separate widgets; all categories chips (trainer edit)
//TODO and fetched categories for trainer/client
//TODO: Ogarnij kategorie -> subkategorie
class PersoCategoryChips extends StatelessWidget {
  const PersoCategoryChips({required List<String> categories, super.key})
      : _categories = categories;

  final List<String> _categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.xsMargin,
        right: Dimens.xsMargin,
      ),
      child: Wrap(
        children: _categories.map((String title) {
          return Container(
            margin: const EdgeInsets.only(
              left: Dimens.xsMargin,
              // right: Dimens.xsMargin,
            ),
            child: FilterChip(
              label: Text(title),
              onSelected: (bool value) {
                //no-op
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
