import 'package:Perso/app/utils/dimens.dart';
import 'package:flutter/material.dart';

class PersoFlagButton extends StatelessWidget {
  const PersoFlagButton({Key? key, required this.flagEmoji}) : super(key: key);

  final String flagEmoji;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Dimens.loginButtonHeight,
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
                Text(flagEmoji),
                Container(
                    margin: EdgeInsets.only(left: Dimens.mediumMargin),
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 14.0,
                      color: Colors.black,
                    ))
              ],
            )));
  }
}
