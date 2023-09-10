import 'package:Perso/app/utils/dimens.dart';
import 'package:flutter/material.dart';

class PersoChipsList extends StatefulWidget {
  PersoChipsList({super.key});

  @override
  State<PersoChipsList> createState() => _PersoChipsListState();
  List<String> categories = [];
}

class _PersoChipsListState extends State<PersoChipsList> {
  final List<String> _chipNames = [
    "Bodybuilding",
    "Yoga",
    "Calisthenics",
    "Cardio",
    "Endurance",
    "Gymnastics",
    "Crossfit"
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: Dimens.smallMargin, right: Dimens.smallMargin),
      child: Wrap(
        spacing: 8.0,
        alignment: WrapAlignment.start,
        // Chips wrap to the next line when reaching the edge
        children: _chipNames.map((String title) {
          return FilterChip(
            label: Text(title),
            selected: widget.categories.contains(title),
            onSelected: (value) {
              handleFilterSelection(title);
            },
          );
        }).toList(),
      ),
    );
  }

  void handleFilterSelection(String filter) {
    setState(() {
      if (widget.categories.contains(filter)) {
        widget.categories.remove(filter);
      } else {
        widget.categories.add(filter);
      }
    });
  }
}
