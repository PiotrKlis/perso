import 'package:Perso/app/models/training_category/training_category.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/training_category_list/perso_training_category_icon.dart';
import 'package:Perso/app/widgets/training_category_list/bloc/training_category_list_bloc.dart';
import 'package:Perso/app/widgets/training_category_list/event/training_category_list_event.dart';
import 'package:Perso/app/widgets/training_category_list/state/training_category_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersoTrainingCategoryList extends StatelessWidget {
  PersoTrainingCategoryList({this.isShortList = false});

  bool isShortList;

  @override
  Widget build(BuildContext context) {
    Widget getPersoCategoryList(List<TrainingCategory> categories) {
      return Column(
          children: categories.map((category) {
        bool shouldDividerBeVisible =
            categories.indexOf(category) != categories.length - 1;
        return InkWell(
          child: SizedBox(
            height: Dimens.trainingCategoryRowHeight,
            child: Column(
              children: [
                Row(
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
                Visibility(
                  visible: shouldDividerBeVisible,
                  child: Container(
                      margin: const EdgeInsets.only(left: Dimens.hugeMargin),
                      child: const Divider()),
                )
              ],
            ),
          ),
        );
      }).toList());
    }

    return BlocProvider(
      create: (context) =>
          TrainingCategoryListBloc(const TrainingCategoryListState.initial()),
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
            return getPersoCategoryList(categories);
          }, error: (String error) {
            return Text(error);
          });
        },
      ),
    );
  }
}
