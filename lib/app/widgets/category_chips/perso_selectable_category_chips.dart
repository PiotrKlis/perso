import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/category_chips/bloc/category_chips_bloc.dart';
import 'package:perso/app/widgets/category_chips/event/category_chips_event.dart';
import 'package:perso/app/widgets/category_chips/state/category_chips_state.dart';
import 'package:perso/core/models/trainer_entity.dart';

class PersoSelectableCategoryChips extends StatefulWidget {
  PersoSelectableCategoryChips({super.key});

  List<String> _selectedCategories = [];

  @override
  State<PersoSelectableCategoryChips> createState() =>
      _PersoSelectableCategoryChipsState();
}

class _PersoSelectableCategoryChipsState
    extends State<PersoSelectableCategoryChips> {
  @override
  Widget build(BuildContext context) {
    context.watch<ProfileEditCubit>().state.whenOrNull(
      preFillData: (profileEntity) {
        final categories = (profileEntity as TrainerEntity).categories;
        widget._selectedCategories = categories;
      },
      sendData: () {
        context
            .read<ProfileEditCubit>()
            .updateCategories(widget._selectedCategories);
      },
    );
    return BlocProvider<CategoryChipsBloc>(
      create: (context) => CategoryChipsBloc()
        ..add(
          const CategoryChipsEvent.loadAllCategories(),
        ),
      child: BlocBuilder<CategoryChipsBloc, CategoryChipsState>(
        builder: (context, state) {
          return state.when(
            initial: Container.new,
            content: (List<String> categories) {
              return Wrap(
                children: categories.map((String title) {
                  return Container(
                    margin: const EdgeInsets.only(
                      left: Dimens.xsMargin,
                    ),
                    child: FilterChip(
                      label: Text(title),
                      selected: widget._selectedCategories.contains(title),
                      onSelected: (value) {
                        handleFilterSelection(title);
                      },
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  void handleFilterSelection(String filter) {
    setState(() {
      if (widget._selectedCategories.contains(filter)) {
        widget._selectedCategories.remove(filter);
      } else {
        widget._selectedCategories.add(filter);
      }
    });
  }
}
