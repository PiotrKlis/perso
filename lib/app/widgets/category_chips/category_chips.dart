import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/category_chips/bloc/category_chips_bloc.dart';
import 'package:Perso/app/widgets/category_chips/event/category_chips_event.dart';
import 'package:Perso/app/widgets/category_chips/state/category_chips_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersoCategoryChips extends StatefulWidget {
  PersoCategoryChips({super.key, this.areChipsSelectable = true});

  final bool areChipsSelectable;

  @override
  State<PersoCategoryChips> createState() => _PersoCategoryChipsState();
  List<String> selectedCategories = [];
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
              context
                  .read<CategoryChipsBloc>()
                  .add(const CategoryChipsEvent.loadData());
              return const Center(child: CircularProgressIndicator());
            },
            content: (List<String> categories) {
              return Container(
                margin: const EdgeInsets.only(
                    left: Dimens.smallMargin, right: Dimens.smallMargin),
                child: Wrap(
                  spacing: Dimens.smallMargin,
                  alignment: WrapAlignment.start,
                  children: categories.map((String title) {
                    return FilterChip(
                      label: Text(title),
                      selected: widget.selectedCategories.contains(title),
                      onSelected: (value) {
                        handleFilterSelection(title);
                      },
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

  void handleFilterSelection(String filter) {
    if (widget.areChipsSelectable) {
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
