import 'package:flutter/material.dart';
import 'package:perso/app/screens/exercise_details/exercise_details_inherited_widget.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoSupersetSection extends StatefulWidget {
  const PersoSupersetSection({super.key});

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
  String _selectedSuperset = '';

  @override
  void initState() {
    super.initState();
    _selectedSuperset = listOfSupersetNames.first;
  }

  @override
  Widget build(BuildContext context) {
    final exerciseInheritedWidget = ExerciseInheritedWidget.of(context);
    final supersetName = exerciseInheritedWidget.exerciseInTrainingEntity
        .exerciseEntity.exerciseOptionsData.supersetName;
    if (supersetName.isNotEmpty) {
      _isEnabled = true;
      _selectedSuperset = supersetName;
    }
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Supersets',
            style: ThemeText.smallTitleBold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add exercise into superset',
                style: ThemeText.bodyRegularBlackText,
              ),
              Switch(
                value: _isEnabled,
                onChanged: (value) {
                  setState(() {
                    _isEnabled = value;
                    if (!value) {
                      exerciseInheritedWidget.supersetController.text = '';
                      exerciseInheritedWidget.updateSuperset('');
                    } else {
                      exerciseInheritedWidget.supersetController.text =
                          _selectedSuperset;
                      exerciseInheritedWidget.updateSuperset(_selectedSuperset);
                    }
                  });
                },
              ),
            ],
          ),
          DropdownMenu<String>(
            enabled: _isEnabled,
            initialSelection: _selectedSuperset,
            onSelected: (String? value) {
              setState(() {
                exerciseInheritedWidget.supersetController.text = value!;
                _selectedSuperset = value;
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
        ],
      ),
    );
  }
}
