import 'package:flutter/material.dart';

class PersoCategoryIcon extends StatelessWidget {
  const PersoCategoryIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.blue, // Button color
        child: InkWell(
          splashColor: Colors.red, // Splash color
          onTap: () {},
          child: SizedBox(width: 56, height: 56, child: Icon(Icons.menu)),
        ),
      ),
    );
  }
}
