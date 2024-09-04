import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/search/exercises/bloc/search_exercises_bloc.dart';
import 'package:perso/app/widgets/search/exercises/event/search_exercises_event.dart';

class PersoExercisesSearch extends StatefulWidget {
  const PersoExercisesSearch({super.key});

  @override
  State<PersoExercisesSearch> createState() => _PersoExercisesSearchState();
}

class _PersoExercisesSearchState extends State<PersoExercisesSearch> {
  @override
  void initState() {
    context.read<SearchExercisesBloc>().add(
          const SearchExercisesEvent.emptySearch(),
        );
    super.initState();
  }

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
                  .read<SearchExercisesBloc>()
                  .add(const SearchExercisesEvent.emptySearch());
            } else {
              context.read<SearchExercisesBloc>().add(
                    SearchExercisesEvent.searchInput(
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
