import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/superset_section/bloc/superset_bloc.dart';
import 'package:perso/app/screens/exercise_details/superset_section/event/superset_event.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/perso_button.dart';

class PersoSupersetSection extends StatefulWidget {
  PersoSupersetSection({
    required String clientId,
    required String date,
    super.key,
  });

  bool shouldShowSupersetCheckboxes = false;
  final superSets = <String, String>{};

  @override
  State<PersoSupersetSection> createState() => _PersoSupersetSectionState();
}

class _PersoSupersetSectionState extends State<PersoSupersetSection> {
  final listOfSupersetNames = <String>[
    'Superset 1',
    'Superset 2',
    'Superset 3',
    'Superset 4',
    'Superset 5',
    'Superset 6',
    'Superset 7',
    'Superset 8',
    'Superset 9',
  ];

  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Supersets', style: ThemeText.smallTitleBold,),
          Container(
            margin: const EdgeInsets.only(top: Dimens.mMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownMenu<String>(
                  enabled: _isEnabled,
                  initialSelection: listOfSupersetNames.first,
                  onSelected: (String? value) {
                    setState(() {
                      // _selectedSupersetName = value!;
                    });
                  },
                  dropdownMenuEntries: listOfSupersetNames
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  }).toList(),
                ),
                Switch(
                  value: _isEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
