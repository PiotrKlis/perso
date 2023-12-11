import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/category_chips/bloc/category_chips_bloc.dart';
import 'package:perso/app/widgets/category_chips/event/category_chips_event.dart';
import 'package:perso/app/widgets/category_chips/state/category_chips_state.dart';

class PersoCategoryChips extends StatefulWidget {
  PersoCategoryChips({
    super.key,
    bool areChipsSelectable = true,
    String? trainerId,
    List<String>? selectedCategories,
    bool shouldHideNotSelectedChips = false,
  })  : _trainerId = trainerId,
        _areChipsSelectable = areChipsSelectable,
        _shouldHideNotSelectedChips = shouldHideNotSelectedChips,
        selectedCategories = selectedCategories ?? [];

  final bool _areChipsSelectable;
  final String? _trainerId;
  final List<String> selectedCategories;
  final bool _shouldHideNotSelectedChips;

  @override
  State<PersoCategoryChips> createState() => _PersoCategoryChipsState();
}

class _PersoCategoryChipsState extends State<PersoCategoryChips> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryChipsBloc>(
      create: (context) => CategoryChipsBloc(),
      child: BlocBuilder<CategoryChipsBloc, CategoryChipsState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              if (widget._trainerId == null) {
                context
                    .read<CategoryChipsBloc>()
                    .add(const CategoryChipsEvent.loadAllCategories());
              } else {
                context.read<CategoryChipsBloc>().add(
                      CategoryChipsEvent.loadCategoriesForTrainer(
                        widget._trainerId!,
                      ),
                    );
              }
              return Container();
            },
            content: (List<String> categories) {
              return Container(
                margin: const EdgeInsets.only(
                  left: Dimens.xsMargin,
                  right: Dimens.xsMargin,
                ),
                child: Wrap(
                  // spacing: Dimens.xsMargin,
                  children: categories.map((String title) {
                    return Visibility(
                      visible: shouldCategoryBeVisible(title),
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: Dimens.xsMargin,
                          // right: Dimens.xsMargin,
                        ),
                        child: FilterChip(
                          label: Text(title),
                          selected: widget.selectedCategories.contains(title),
                          onSelected: (value) {
                            handleFilterSelection(title);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  bool shouldCategoryBeVisible(String title) {
    if (widget._shouldHideNotSelectedChips) {
      return widget.selectedCategories.contains(title);
    } else {
      return true;
    }
  }

  void handleFilterSelection(String filter) {
    if (widget._areChipsSelectable) {
      setState(() {
        if (widget.selectedCategories.contains(filter)) {
          widget.selectedCategories.remove(filter);
        } else {
          widget.selectedCategories.add(filter);
        }
      });
    }
  }
}
