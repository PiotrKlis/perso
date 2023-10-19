import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoFlagButton extends StatelessWidget {
  const PersoFlagButton(
      {Key? key,
      required this.flagEmoji,
      required void Function(String languageEmoji) this.onRemoveTap})
      : super(key: key);

  final String flagEmoji;
  final Function(String languageEmoji) onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48.0,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimens.buttonBorderRadius))),
            onPressed: () {},
            child: Row(
              children: [
                Text(
                  flagEmoji,
                  style: TextStyle(fontSize: 24.0),
                ),
                Container(
                    margin: const EdgeInsets.only(left: Dimens.mediumMargin),
                    child: GestureDetector(
                      onTap: () {
                        onRemoveTap.call(flagEmoji);
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ))
              ],
            )));
  }
}
