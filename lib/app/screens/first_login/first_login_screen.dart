import 'package:Perso/app/widgets/PersoAppBar.dart';
import 'package:flutter/material.dart';

class FirstLoginScreen extends StatelessWidget {
  const FirstLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PersoAppBar(title: "Welcome to PERSO"),
      body: Center(
        child: Text("Welcome to PERSO"),
      ),
    );
  }
}
