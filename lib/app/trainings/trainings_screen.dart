import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("training screen")),
        body: ElevatedButton(
          onPressed: () {
            // context.go('/trainings/training_details');
          },
          child: Text("I am training body"),
        )
    );
  }
}
