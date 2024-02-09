import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoFlagButton extends StatelessWidget {
  const PersoFlagButton({
    required String flagEmoji,
    required void Function(String languageEmoji) this.onRemoveTap,
    super.key,
  }) : _flagEmoji = flagEmoji;

  final String _flagEmoji;
  final Function(String languageEmoji) onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonBorderRadius),
          ),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Text(
              _flagEmoji,
              style: const TextStyle(fontSize: 24),
            ),
            Container(
              margin: const EdgeInsets.only(left: Dimens.mMargin),
              child: GestureDetector(
                onTap: () {
                  onRemoveTap.call(_flagEmoji);
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
