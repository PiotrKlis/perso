import 'package:flutter/material.dart';

class TrainingDetailsScreen extends StatelessWidget {
  const TrainingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("training screen detils")),
      body: const Text("I am training screen detils body"),
    );
  }
}
