import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_creation/exercise_creation_screen.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_flag_button.dart';
import 'package:perso/app/widgets/perso_small_button.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/models/trainer_entity.dart';

class PersoAddSpokenLanguage extends StatefulWidget {
  const PersoAddSpokenLanguage({super.key});

  @override
  State<PersoAddSpokenLanguage> createState() =>
      _PersoAddSpokenLanguageState();
}

class _PersoAddSpokenLanguageState
    extends State<PersoAddSpokenLanguage> {
  Map<String, Widget> languageMap = {};

  @override
  Widget build(BuildContext context) {
    final languageWidgets = languageMap.values.toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: Dimens.xmMargin,
              top: Dimens.xsMargin,
            ),
            child: const Icon(Icons.flag, size: 24),
          ),
          Container(
            margin: const EdgeInsets.only(left: Dimens.xmMargin),
            child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
                builder: (context, state) {
              state.whenOrNull(
                preFillData: (profileEntity) {
                  final languages = (profileEntity as TrainerEntity).languages;
                  for (final language in languages) {
                    _addSpokenLanguage(language);
                  }
                },
                sendData: () {
                  context
                      .read<ProfileEditCubit>()
                      .updateLanguages(languageMap.keys.toList());
                },
              );
              return PersoLanguageButton(
                text: context.strings.add_language,
                addLanguage: _addSpokenLanguage,
                customValidator: _validateNumberOfLanguages,
              );
            }),
          ),
          ...languageWidgets,
        ],
      ),
    );
  }

  String? _validateNumberOfLanguages() =>
      languageMap.isEmpty ? context.strings.add_language_validator : null;

  void _addSpokenLanguage(String languageEmoji) {
    final Widget languageChip = Container(
      margin: const EdgeInsets.only(left: Dimens.xmMargin),
      child: PersoFlagButton(
        flagEmoji: languageEmoji,
        onRemoveTap: _removeSpokenLanguage,
      ),
    );
    setState(() {
      languageMap.addAll({languageEmoji: languageChip});
    });
  }

  void _removeSpokenLanguage(String languageEmoji) {
    setState(() {
      languageMap.removeWhere(
        (key, value) {
          return key == languageEmoji;
        },
      );
    });
  }
}
