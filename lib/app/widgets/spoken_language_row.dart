import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_flag_button.dart';
import 'package:perso/app/widgets/perso_small_button.dart';

class SpokenLanguageRowWidget extends StatefulWidget {
  SpokenLanguageRowWidget({super.key});

  //TODO: Rozbij widget na dwa, jeden z listą języków, drugi z przyciskiem widgetem
  //TODO: Jeden internalowy, drugi widoczny na zewnątrz
  List<Map<String, Widget>> listOfLanguages = [];

  void addLanguage(List<String> languageEmoji) {
    for (final language in languageEmoji) {
      _addSpokenLanguage(language);
    }
  }

  void _addSpokenLanguage(String languageEmoji) {
    final Widget languageChip = Container(
      margin: const EdgeInsets.only(left: Dimens.xmMargin),
      child: PersoFlagButton(
        flagEmoji: languageEmoji,
        onRemoveTap: _removeSpokenLanguage,
      ),
    );
    listOfLanguages.add({languageEmoji: languageChip});
  }

  void _removeSpokenLanguage(String languageEmoji) {
    listOfLanguages
        .removeWhere((element) => element.containsKey(languageEmoji));
  }

  @override
  State<SpokenLanguageRowWidget> createState() =>
      _SpokenLanguageRowWidgetState();
}

class _SpokenLanguageRowWidgetState extends State<SpokenLanguageRowWidget> {
  @override
  Widget build(BuildContext context) {
    final languageWidgets = widget.listOfLanguages
        .map((map) => map.values.toList())
        .expand((list) => list)
        .toList();

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
            child: PersoSmallButton(
              text: 'Add language',
              addLanguage: _addSpokenLanguage,
              customValidator: _validateNumberOfLanguages,
            ),
          ),
          ...languageWidgets,
        ],
      ),
    );
  }

  String? _validateNumberOfLanguages() =>
      widget.listOfLanguages.isEmpty ? 'Add at least one language' : null;

  void _addSpokenLanguage(String languageEmoji) {
    final Widget languageChip = Container(
      margin: const EdgeInsets.only(left: Dimens.xmMargin),
      child: PersoFlagButton(
        flagEmoji: languageEmoji,
        onRemoveTap: _removeSpokenLanguage,
      ),
    );
    setState(() {
      widget.listOfLanguages.add({languageEmoji: languageChip});
    });
  }

  void _removeSpokenLanguage(String languageEmoji) {
    setState(() {
      widget.listOfLanguages
          .removeWhere((element) => element.containsKey(languageEmoji));
    });
  }
}
