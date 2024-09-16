import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/category_chips/bloc/category_chips_bloc.dart';
import 'package:perso/app/widgets/category_chips/event/category_chips_event.dart';
import 'package:perso/app/widgets/category_chips/state/category_chips_state.dart';

//TODO: Ogarnij kategorie -> subkategorie
class PersoSelectableCategoryChips extends StatefulWidget {
  PersoSelectableCategoryChips({super.key, this.selectedCategories = const []});

  List<String> selectedCategories;

  @override
  State<PersoSelectableCategoryChips> createState() =>
      _PersoSelectableCategoryChipsState();

  void updateData(List<String> selectedCategories) {
    this.selectedCategories = selectedCategories;
  }
}

class _PersoSelectableCategoryChipsState
    extends State<PersoSelectableCategoryChips> {
  @override
  Widget build(BuildContext context) {
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
                      selected: widget.selectedCategories.contains(title),
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
      if (widget.selectedCategories.contains(filter)) {
        widget.selectedCategories.remove(filter);
      } else {
        widget.selectedCategories.add(filter);
      }
    });
  }
}
