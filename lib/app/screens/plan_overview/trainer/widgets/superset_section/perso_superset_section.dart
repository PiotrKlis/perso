import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/superset_section/bloc/superset_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/superset_section/event/superset_event.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/app/widgets/perso_button.dart';

class PersoSupersetSection extends StatefulWidget {
  PersoSupersetSection({required String clientId, super.key})
      : _clientId = clientId;

  final String _clientId;
  bool shouldShowSupersetCheckboxes = false;
  final superSets = <String, String>{};

  @override
  State<PersoSupersetSection> createState() => _PersoSupersetSectionState();
}

class _PersoSupersetSectionState extends State<PersoSupersetSection> {
  String _supersetButtonTitle = 'Create superset';
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

  String _selectedSupersetName = '';
  String _selectedDate = DateTime.now().yearMonthDayFormat;

  @override
  void initState() {
    super.initState();
    _selectedSupersetName = listOfSupersetNames.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.mMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ColoredBox(
            color: PersoColors.lightWhite,
            child: DropdownMenu<String>(
              initialSelection: listOfSupersetNames.first,
              onSelected: (String? value) {
                setState(() {
                  _selectedSupersetName = value!;
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
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: Dimens.mMargin),
              child: BlocListener<CalendarBloc, CalendarState>(
                listener: (context, state) {
                  state.whenOrNull(
                    selectedDate: (selectedDate) {
                      _selectedDate = selectedDate;
                    },
                  );
                },
                child: PersoButton(
                  title: _supersetButtonTitle,
                  whiteBlackTheme: true,
                  onTap: (context) {
                    setState(() {
                      _handleButtonTap(
                        widget._clientId,
                        _selectedDate,
                        _selectedSupersetName,
                      );
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleButtonTap(
    String clientId,
    String date,
    String selectedSuperSetName,
  ) {
    widget.shouldShowSupersetCheckboxes = !widget.shouldShowSupersetCheckboxes;
    _updateButtonText();
    _updateSupersetList(clientId, date);
    if (widget.shouldShowSupersetCheckboxes) {
      context.read<SupersetBloc>().add(
            SupersetEvent.changeCheckboxesVisibility(
              shouldCheckboxesBeVisible: widget.shouldShowSupersetCheckboxes,
            ),
          );
    } else {
      context.read<SupersetBloc>().add(
            SupersetEvent.changeCheckboxesVisibility(
              shouldCheckboxesBeVisible: widget.shouldShowSupersetCheckboxes,
            ),
          );
      context.read<SupersetBloc>().add(
            SupersetEvent.sendSupersetData(
              clientId: clientId,
              date: date,
              supersetName: selectedSuperSetName,
            ),
          );
    }
  }

  void _updateButtonText() {
    _supersetButtonTitle =
        widget.shouldShowSupersetCheckboxes ? 'Confirm' : 'Create superset';
  }

  void _updateSupersetList(
    String clientId,
    String date,
  ) {
    if (!widget.shouldShowSupersetCheckboxes) {
      context.read<SupersetBloc>().add(
            SupersetEvent.sendSupersetData(
              clientId: clientId,
              date: date,
              supersetName: _selectedSupersetName,
            ),
          );
    }
  }
}
