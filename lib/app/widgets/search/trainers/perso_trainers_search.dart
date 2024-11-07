import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/search/trainers/bloc/search_trainers_bloc.dart';
import 'package:perso/app/widgets/search/trainers/event/search_trainers_event.dart';

class PersoTrainersSearch extends StatelessWidget {
  const PersoTrainersSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          backgroundColor: const WidgetStatePropertyAll<Color>(
            PersoColors.lighterGrey,
          ),
          controller: controller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
          onChanged: (input) {
            if (input.isEmpty) {
              context
                  .read<SearchTrainersBloc>()
                  .add(const SearchTrainersEvent.emptyTrainersSearch());
            } else {
              context.read<SearchTrainersBloc>().add(
                    SearchTrainersEvent.searchTrainersInput(
                      controller.text,
                    ),
                  );
            }
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return [];
      },
    );
  }
}
