import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('training screen')),
        body: ElevatedButton(
          onPressed: () {
            // context.go('/trainings/training_details');
          },
          child: const Text('I am training body'),
        ),);
  }
}
