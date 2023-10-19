import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/models/training_category/training_category.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_indented_divider.dart';
import 'package:perso/app/widgets/training_category_list/bloc/training_category_list_bloc.dart';
import 'package:perso/app/widgets/training_category_list/event/training_category_list_event.dart';
import 'package:perso/app/widgets/training_category_list/perso_training_category_icon.dart';
import 'package:perso/app/widgets/training_category_list/state/training_category_list_state.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PersoTrainingCategoryList extends StatelessWidget {
  const PersoTrainingCategoryList({super.key, this.isShortList = false});

  final bool isShortList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainingCategoryListBloc(),
      child: BlocBuilder<TrainingCategoryListBloc, TrainingCategoryListState>(
        builder: (context, state) {
          return state.when(initial: () {
            TrainingCategoryListBloc bloc =
                context.read<TrainingCategoryListBloc>();
            if (isShortList) {
              bloc.add(const TrainingCategoryListEvent.loadShortList());
            } else {
              bloc.add(const TrainingCategoryListEvent.loadAll());
            }
            return Container();
          }, content: (List<TrainingCategory> categories) {
            return _getPersoCategoryList(categories, context);
          }, error: (String error) {
            return Text(error);
          });
        },
      ),
    );
  }

  Widget _getPersoCategoryList(
      List<TrainingCategory> categories, BuildContext context) {
    return Column(
        children: categories.map((category) {
      bool shouldDividerBeVisible =
          categories.indexOf(category) != categories.length - 1;
      return GestureDetector(
        onTap: () => context.pushNamed(ScreenNavigationKey.searchResults,
            pathParameters: {"input": category.name}),
        child: SizedBox(
          height: Dimens.trainingCategoryRowHeight,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    PersoTrainingCategoryIcon(
                        path: category.trainingCategoryIcon.path,
                        color: category.trainingCategoryIcon.color),
                    Container(
                        margin:
                            const EdgeInsets.only(left: Dimens.normalMargin),
                        child: Text(category.name,
                            style: ThemeText.bodyBoldBlackText))
                  ],
                ),
              ),
              Visibility(
                visible: shouldDividerBeVisible,
                child: const PersoIndentedDivider(),
              )
            ],
          ),
        ),
      );
    }).toList());
  }
}
