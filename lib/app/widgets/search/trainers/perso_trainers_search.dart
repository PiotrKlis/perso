import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/search/trainers/bloc/search_trainers_bloc.dart';
import 'package:perso/app/widgets/search/trainers/event/search_trainers_event.dart';

class PersoTrainersSearch extends StatelessWidget {
  const PersoTrainersSearch({required String initialText, super.key})
      : _initialText = initialText;

  final String _initialText;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        _handleInitialInput(controller, context);
        return SearchBar(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
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
              _searchTrainers(context, controller.text);
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

  void _handleInitialInput(SearchController controller, BuildContext context) {
    if (_initialText.trim().isNotEmpty) {
      controller.text = _initialText ?? '';
      _searchTrainers(context, controller.text);
    }
  }

  void _searchTrainers(BuildContext context, String input) {
    context.read<SearchTrainersBloc>().add(
          SearchTrainersEvent.searchTrainersInput(
            input,
          ),
        );
  }
}
