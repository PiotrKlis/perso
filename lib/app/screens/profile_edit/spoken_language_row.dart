import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/perso_flag_button.dart';
import 'package:Perso/app/widgets/perso_small_button.dart';
import 'package:flutter/material.dart';

class SpokenLanguageRowWidget extends StatefulWidget {
  const SpokenLanguageRowWidget({Key? key}) : super(key: key);

  @override
  State<SpokenLanguageRowWidget> createState() =>
      _SpokenLanguageRowWidgetState();
}

class _SpokenLanguageRowWidgetState extends State<SpokenLanguageRowWidget> {
  List<Map<String, Widget>> listOfLanguages = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> languageWidgets = listOfLanguages
        .map((map) => map.values.toList())
        .expand((list) => list)
        .toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: Dimens.normalMargin),
              child: const Icon(Icons.flag, size: 24.0)),
          Container(
              margin: const EdgeInsets.only(left: Dimens.normalMargin),
              child: PersoSmallButton(
                text: "Add language",
                addLanguage: _addSpokenLanguage,
                customValidator: _validateNumberOfLanguages,
              )),
          ...languageWidgets
        ],
      ),
    );
  }

  String? _validateNumberOfLanguages() =>
      listOfLanguages.isEmpty ? "Add at least one language" : null;

  void _addSpokenLanguage(String languageEmoji) {
    Widget languageChip = Container(
        margin: const EdgeInsets.only(left: Dimens.normalMargin),
        child: PersoFlagButton(
            flagEmoji: languageEmoji, onRemoveTap: _removeSpokenLanguage));
    setState(() {
      listOfLanguages.add({languageEmoji: languageChip});
    });
  }

  void _removeSpokenLanguage(String languageEmoji) {
    setState(() {
      listOfLanguages
          .removeWhere((element) => element.containsKey(languageEmoji));
    });
  }
}
